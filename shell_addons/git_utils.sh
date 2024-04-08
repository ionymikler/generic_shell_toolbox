# start prompt in next line from https://bashrcgenerator.com/
function parse_git_branch() {
 git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'
}

function get_repository_name() {
  # TODO: For lond basedir names, tale the first X characters
  if git rev-parse --is-inside-work-tree &>/dev/null; then
    git rev-parse --show-toplevel | xargs basename
  else
    echo ""
  fi
}
