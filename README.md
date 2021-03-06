# Apple Stats

This is a is my submission for the "Statistically Thinking" coding exercise.

A couple of points to note:

* Using the DSL was incredibly slow to insert 1,000,000 records. Building SQL statements and inserting in batches proved to be the best solution. You can see the data loader in the `lib/` directory. I was able to get the load time down to about 44 secs based on my benchmarks.

* Delivering the stats data also proved to be extremely slow when aggregated using ruby. I tried to put as much load as I could on the database to give me the most complete dataset in the initial query. Leveraging Postgres specific functions helped to better manage the return record set.

* Everything is assumed to be and converted to UTC. This is important because the database and the Rails timezone can differ. Results may vary if standardization is not in place.

## Make It Run!

You may want to have RVM or rbenv set up, but I will leave that up to the consumer. Once you have pulled the code down, run the following commands:

```
bundle install

rake db:create

rake db:migrate

rake db:seed

foreman start
```
( note: `rake db:setup` is sort of wonky with the Sequel adapater. Not sure why. Hence the multi-step process. )

To run the tests execute the following commands:

```
rake db:test:prepare
rails test
```

## Final Words

I really had fun with this project. I could have kept going. Please let me know if you have any questions.

Thanks,
Nick
