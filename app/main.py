from flask import Flask, render_template, request, redirect, session
import os
import subprocess

app = Flask(__name__)
app.secret_key = 'mysecret'

@app.route('/')
def index():
    if 'user' in session:
        return render_template('index.html', user=session['user'])
    return redirect('/login')

@app.route('/login', methods=['GET', 'POST'])
def login():
    if request.method == 'POST':
        if request.form['username'] == 'jerry' and request.form['password'] == 'ymn777!2':
            session['user'] = 'jerry'
            return redirect('/')
        return 'Invalid login'
    return render_template('login.html')

@app.route('/logout')
def logout():
    session.pop('user', None)
    return redirect('/login')

@app.route('/console', methods=['GET', 'POST'])
def console():
    if 'user' not in session:
        return redirect('/login')
    
    output = ""
    if request.method == 'POST':
        cmd = request.form.get('cmd')
        try:
            output = subprocess.check_output(cmd, shell=True, stderr=subprocess.STDOUT, timeout=3, text=True)
        except Exception as e:
            output = f"Error: {str(e)}"
    return render_template('console.html', output=output)

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)

