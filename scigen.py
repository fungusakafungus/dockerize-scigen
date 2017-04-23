from bottle import route, run, static_file, response, request, template
import subprocess
import shlex
import os


def ps():
    os.system('rm -rf output.ps')
    sysname = ''
    if request.query.sysname:
        sysname = ' --sysname "' + request.query.sysname + '"'
    cmd = './make-latex.pl --file /scigen/output.ps' + sysname
    proc = subprocess.Popen(shlex.split(cmd), cwd='/scigen/scigen/scigen',
                            stdout=subprocess.PIPE,
                            stderr=subprocess.STDOUT)
    (stdoutdata, _) = proc.communicate()
    return proc.returncode, stdoutdata


@route('/')
def pdf():
    returncode, stdoutdata = ps()
    if returncode == 0:
        os.system('ps2pdf /scigen/output.ps /scigen/output.pdf')
        return static_file('/scigen/output.pdf', root='/', mimetype='application/pdf')
    else:
        return stdoutdata


@route('/errors')
def errors():
    returncode, stdoutdata = ps()
    response.content_type = 'text/plain'
    return stdoutdata


@route('/refresh')
def refresh():
    status = os.system('cd /scigen/scigen/scigen; git pull origin master')
    response.content_type = 'text/plain'
    return 'refreshed' if status == 0 else 'could not refresh'


@route('/savedir/')
def output_files():
    os.system('rm -rf /scigen/savedir/')
    os.system('mkdir /scigen/savedir/')
    proc = subprocess.Popen('./make-latex.pl --savedir /scigen/savedir'.split(),
                            cwd='/scigen/scigen/scigen', stdout=subprocess.PIPE,
                            stderr=subprocess.STDOUT)
    (stdoutdata, _) = proc.communicate()
    l = os.listdir('/scigen/savedir/')
    return template('index', files=l)


@route('/savedir/<filename>')
def output_file(filename):
    return static_file(filename, root='/scigen/savedir')


run(host='0.0.0.0', port=8080, debug=True)
