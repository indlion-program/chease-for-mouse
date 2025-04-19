FROM ubuntu:latest

# Update and install required packages
RUN apt-get update && apt-get install -y \
    openssh-server \
    python3 \
    python3-pip \
    python3-venv \
    && apt-get clean

# Create users and passwords
RUN useradd -m jerry && \
    echo "root:zm6Y5413sfFa" | chpasswd && \
    echo "jerry:ymn777!2" | chpasswd

# Fix SSH Setup
RUN mkdir -p /var/run/sshd && \
    chmod 0755 /var/run/sshd

# Correct SSH Key Location (must be in user's home)
RUN mkdir -p /home/jerry/.ssh && \
    chmod 700 /home/jerry/.ssh
COPY jerry_id_rsa.pub /home/jerry/.ssh/authorized_keys
RUN chown -R jerry:jerry /home/jerry/.ssh && \
    chmod 600 /home/jerry/.ssh/authorized_keys && \
    chmod 755 /home/jerry  # Critical for SSH

# Rest of your original setup remains unchanged
COPY ReadMe.txt /home/jerry/ReadMe.txt
RUN chown jerry:jerry /home/jerry/ReadMe.txt && \
    chmod 600 /home/jerry/ReadMe.txt

COPY sshd_config /etc/ssh/sshd_config
WORKDIR /home/jerry/app
COPY ./app /app
RUN python3 -m venv /app/venv && \
    /app/venv/bin/pip install flask && \
    chown -R jerry:jerry /app

COPY run_as_root.sh /root/run_as_root.sh
RUN chmod +x /root/run_as_root.sh

EXPOSE 22 5000

# Fixed CMD (only one CMD instruction)
CMD /bin/bash -c "/usr/sbin/sshd -D & /root/run_as_root.sh & su - jerry -c '/app/venv/bin/python /app/main.py'"
