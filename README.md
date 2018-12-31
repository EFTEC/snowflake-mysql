# snowflake-mysql
![snowflake.jpg](snowflake.jpg)

using twitter snowflake on mysql function. it's create global auto increment table to provide database level id generator. 

***notice: the generator function used mysql `REPLACE INTO` statement, so you can't be use `AUTO_INCREMENT` on other tables.***

## Considerations.

This generator of code is based on Twitter Bootstrap.  It uses an epoch to determine the different (in 1/1000th seconds) between the epoch and the current date and time.

It also allows to set a node/id, so it is possible to generate unique Id's even in a cluster-server without replications.   It only allows up to 1024 nodes.

It also has protection for a race condition.  It uses a sequence generator that it's rotated every 4096 iterations.

So, the library is safe, and it will ensure a unique number if and only if:

* There is less than 4096 iterations every 1/1000th seconds per each node. So, if a system requires to create 4 million ids per second, then it is not your library.
* If it's running in a different server, then each server must use a unique identifier (node id).


### Why does this library needs a table?

Let's say we are creating a new id using node 1 at 2018-01-01 01:01:01.1234 
What if another thread is calling it the function and it's creating a new id at the exact same time 2018-01-01 01:01:01.1234   

Then, we are avoiding a collision by adding a new sequence. This sequence rotates every 4096 interactions.  So, if we are creating a node at the same time, then the sequence is still unique unless we are creating 4096 ids at the same time.


## Usage

### Installation:

* 1) Run the next script: [snowflake_ddl.sql](snowflake_ddl.sql)

It will create the table and it will add a new row.

It also marks the database and it will allow to create a non deterministic function that modifies the database

```
SET GLOBAL log_bin_trust_function_creators = 1;
```

* 2) Then run the next script [next_snowflake.sql](next_snowflake.sql)

It will create a new function.

* 3) Finally, you could use as

```
select next_snowflake(1)  -- where 1 is the number of the node.  It will return the number (int-64 / bigint) value
```

It is also integrated in the library DaoOne (MIT License).

https://github.com/EFTEC/DaoOne

```php
$dao->getSequence() // string(19) "3639032938181434317" 
```


