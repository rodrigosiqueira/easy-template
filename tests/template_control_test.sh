. ./easy-template.sh --source-only
. $(dirname $0)/helper/test_helper.sh

test_template_control_list ()
{
  local first_line=$(template_control -l | head -1)
  assertEquals 'Usage: easy-template [OPTION] [p path]' "$first_line"
}

load_shunit2
