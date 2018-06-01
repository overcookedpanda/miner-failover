# pool failover script by Overcooked Panda
#
# Enter your default pool at the bottom, enter secondary pool on Line 39
# Set the value for 'timeout' to kill the miner and check default pool. 
#
# Use at your own risk, and good luck!
#########################################################################
# Original snippet from phs on stackoverflow.
#
# Retries a command a configurable number of times with backoff.
#
# The retry count is given by ATTEMPTS (default 5), the initial backoff
# timeout is given by TIMEOUT in seconds (default 1.)
#
# Successive backoffs double the timeout.
function with_backoff {
  local max_attempts=${ATTEMPTS-5}
  local timeout=${TIMEOUT-1}
  local attempt=1
  local exitCode=0

  while (( $attempt < $max_attempts ))
  do
    if "$@"
    then
      return 0
    else
      exitCode=$?
    fi

    echo "Pool Died! Retrying in $timeout.." 1>&2
    sleep $timeout
    attempt=$(( attempt + 1 ))
    timeout=$(( timeout * 2 ))
  done

  if [[ $exitCode != 0 ]]
  then
    timeout 30m ./secondary_miner_program additional start string (wallet, pool, user, pass, etc)
  fi

  return $exitCode
}

while [ true ]
do
    with_backoff ./default_miner_program ./miner_program additional start string (wallet, pool, user, pass, etc)
done
