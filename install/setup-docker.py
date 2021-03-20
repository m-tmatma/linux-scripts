#!/usr/bin/python3

import string
import subprocess
import os
import sys
import shutil

###########################################################################
#  template for /etc/apt/apt.conf
###########################################################################
template_apt_conf = """\
Acquire::http::Proxy "$http_proxy_url";
Acquire::https::Proxy "$https_proxy_url";
"""


###########################################################################
#  template for /etc/systemd/system/docker.service.d/override.conf
###########################################################################
template_docker_service_override = """\
[Service]
Environment="HTTP_PROXY=$http_proxy_url"
Environment="HTTPS_PROXY=$https_proxy_url"
Environment="NO_PROXY=localhost,127.0.0.1"
"""

###########################################################################
#  template for ~/.docker/config.json
###########################################################################
template_config_json = """\
{
  "proxies": {
    "default": {
      "httpProxy": "$http_proxy_url",
      "httpsProxy": "$https_proxy_url",
      "noProxy": "localhost,127.0.0.1"
    }
  }
}
"""


###########################################################################
#  write proxy data to a file
###########################################################################
def write_proxy(file_name, input_template, http_proxy_url, https_proxy_url):
    if http_proxy_url or https_proxy_url:
        context = {
            'http_proxy_url' : http_proxy_url,
            'https_proxy_url' : https_proxy_url
        }
        template = string.Template(input_template)
        data = template.substitute(context)

        with open(file_name, "w") as fout:
            fout.write(data)
        print("wrote: " + file_name)
    else:
        if os.path.exists(file_name):
            shutil.rmtree(file_name)
        print("removed: " + file_name)

###########################################################################
#  get the home directory of the original user
###########################################################################
def get_original_home():
    user = os.environ['SUDO_USER']
    if user:
        home_dir = os.path.expanduser('~' + user)
    else:
        home_dir = os.path.expanduser('~')
    return home_dir

###########################################################################
#  write etc/apt/apt.conf
###########################################################################
def write_apt_conf(http_proxy_url, https_proxy_url):
    write_proxy('/etc/apt/apt.conf', template_apt_conf, http_proxy_url, https_proxy_url)

###########################################################################
#  write /etc/systemd/system/docker.service.d/override.conf
###########################################################################
def write_docker_service_override(http_proxy_url, https_proxy_url):
    docker_service_d = '/etc/systemd/system/docker.service.d'
    if not os.path.isdir(docker_service_d):
        os.mkdir(docker_service_d)

    override_conf = os.path.join(docker_service_d, "override.conf")
    write_proxy(override_conf, template_docker_service_override, http_proxy_url, https_proxy_url)

###########################################################################
#  write ~/.docker/config.json
###########################################################################
def write_docker_config(http_proxy_url, https_proxy_url):
    # get the path of ~/.docker
    home_dir = get_original_home()
    docker_dir = os.path.join(home_dir, ".docker")

    # create ~/.docker
    if not os.path.isdir(docker_dir):
        os.mkdir(docker_dir)

    # get ~/.docker/config.json
    config_json = os.path.join(docker_dir, "config.json")
    write_proxy(config_json, template_config_json, http_proxy_url, https_proxy_url)

###########################################################################
#  usage
###########################################################################
def usage():
    script = sys.argv[0]
    print("usage:")
    print("sudo " + script + " set http://proxy:port")
    print("sudo " + script + " noproxy")

def exec(command):
    subprocess.call(command.split(), shell=False)
    print("ran: " + command)

if __name__ == '__main__':
    if len(sys.argv) < 2 or os.getuid() != 0:
        usage()
        sys.exit(1)

    http_proxy_url = None
    https_proxy_url = None
    cmd = sys.argv[1]
    if cmd == "set":
        if len(sys.argv) == 3:
            http_proxy_url = sys.argv[2]
            https_proxy_url = sys.argv[2]
        else:
            usage()
            sys.exit(1)
    elif cmd == "noproxy":
        pass
    else:
        usage()
        sys.exit(1)

    write_apt_conf(http_proxy_url, https_proxy_url)
    write_docker_service_override(http_proxy_url, https_proxy_url)
    write_docker_config(http_proxy_url, https_proxy_url)

    if shutil.which('docker') is None:
        exec('apt install -y docker.io docker-compose')
    exec('systemctl daemon-reload')
    exec('systemctl restart docker')
