# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Example:
#
#   Person.create(first_name: 'Eric', last_name: 'Kelly')

Meetup.create(name: 'Testing ActiveRecord', description: 'This is a test to make sure I know what whats going on', location: '53 Harrison Ave.')

Meetup.create(name: 'Testing multiple records', description: 'This is a test to make sure I know what whats going on', location: '53 Harrison Ave.')

Meetup.create(name: 'Does it add rows that are false', description: 'This is a test to make sure I know what whats going on', location: '53 Harrison Ave.')

UserMeetup.create(user_id: 1, meetup_id: 1)

UserMeetup.create(user_id: 1, meetup_id: 2)
