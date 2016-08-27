################
# Global aliases
################
alias reload!='source ~/.zshrc'
alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'
alias -g C='| wc -l'
alias -g H='| head'
alias -g L="| less"
alias -g N="| /dev/null"
alias -g S='| sort'
alias -g G='| grep' # now you can do: ls foo G something
alias rmDerived='rm -rf ~/library/Developer/Xcode/DerivedData/*'


##########################
# Global environment vars
#########################
# RbEnv Stuff
export PATH="$HOME/.rbenv/bin:$PATH"
export PATH="$HOME/.rbenv/shims:$PATH"
if which rbenv > /dev/null; then eval "$(rbenv init - zsh)"; fi

###########
# Functions
###########
#
# (f)ind by (n)ame
# usage: fn foo
# to find all files containing 'foo' in the name
function fn() { ls **/*$1* }

# Boot2Docker
docker-ip() {
  boot2docker ip 2> /dev/null
}

# grabs your ip address
function hosts
{
  file=/etc/hosts
  if [ -e $file ]; then
    ip=`ifconfig  | grep -E 'inet.[0-9]' | grep -v '127.0.0.1' | awk 'NR==1{ print $2}'`
    if ! grep -x ".*[[:space:]]*laptop$" $file; then
      echo "$ip laptop" | sudo tee -a $file
    else
      sudo sed -i '.bak' "s/.*[[:space:]]*laptop$/$ip laptop/" $file
    fi
  fi
}

function ipaddr
{
 ifconfig  | grep -E 'inet.[0-9]' | grep -v '127.0.0.1' | awk 'NR==1{ print $2}'
}

# Jenkins
triggerBuild() {
  REPO="$1"
  BRANCH="$2"
  curl -g "http://jenkins.dev-utopia.com/git/notifyCommit?url=ssh://git@stash.itriagehealth.com/projects/ITH/repos/$REPO.git&branch=$BRANCH"
}
