. $(dirname $0)/helper/test_helper.sh

test_verify_help ()
{
  source ./easy-template.sh
  output=`easy-template -h`
  assertEquals 0 "$?"
}

load_shunit2
