export PROXY_HOST=http://10.0.2.2:10081

alias enaproxy="export http_proxy=\$PROXY_HOST https_proxy=\$PROXY_HOST"
alias disproxy="export http_proxy= https_proxy="
export no_proxy="localhost,127.0.0.1,taobao.org"