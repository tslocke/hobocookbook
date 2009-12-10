# Hobo in Two Minutes

To build a Hobo app you need to have a working Rails setup. If you can
create a Rails app and have it connect to a database, you're all set.
You need at least version 2.2 of Rails:

     $ rails -v

First install Hobo:

	$ gem install hobo
	
Now create an app! We've only got two minutes so we'll create an ultra-useful Thing Manager.

	$ hobo thingybob
	
	...Lots of output as Hobo runs the rails command,
	...installs plugins and runs generators
	
	$ cd thingybob
	$ ruby script/generate hobo_model_resource thing name:string body:text
	$ ruby script/generate hobo_migration
	
	...Respond to the prompt with 'm'
	...then press enter to chose the default filename
	
	$ ruby script/server
	
And browse to

	http://localhost:3000
	
And there is your app! You should be able to

* Sign up
* Create and edit Things
* Search for things

That's it. Why not try another of the tutorials on your left.
