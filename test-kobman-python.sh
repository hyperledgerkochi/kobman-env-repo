#!/bin/bash

function __test_kob_init
{
	if [[ ! -d $KOBMAN_DIR ]]; then
        echo "kob not found"
        echo "Please install KOBman and try again"
        echo "Exiting!"
        exit 1
    else
    	source $KOBMAN_DIR/bin/kobman-init.sh
    	source $KOBMAN_DIR/src/kobman-utils.sh
        
    fi

    python3 --version | grep -qi "python"
    if [[ "$?" != "0" ]]; then
        echo "No python package found. Test failed!"
        echo "Exiting!"
        exit 1
    fi
}

##function __test_kob_execute

function __test_kob_validate
{
    __kobman_validate_python
    local ret_value=$?
    if [[ $ret_value == "1" ]]; then
        test_status="failed"
        return 1
    fi
    unset ret_value
}

function __test_kob_run
{
    test_status="success"
    __test_kob_init
    # __test_kob_execute
    __test_kob_validate
    # __test_kob_cleanup
    if [[ $test_status == "success" ]]; then
        __kobman_echo_green "test-kob-python-dev success"
    else
        __kobman_echo_red "test-kob-python-dev failed"
    fi
}

__test_kob_run
