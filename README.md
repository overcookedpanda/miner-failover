# miner-failover
A pool failover script to use on HiveOS or other linux when you have to run a manual miner process.

This script can be modified to failover to an additional pool, or different coin, etc.  It checks the default and then if it fails, rolls to the backup command, times out after 30 minutes and checks your default again.

Very useful for coins that have special miners and pools that go down often.
