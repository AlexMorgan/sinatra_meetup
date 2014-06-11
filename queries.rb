user = User.create(provider: 'github', uid: '5647381', email:'omid@gmail.com', username: 'OmidBachari', avatar_url: 'https://s3.amazonaws.com/Launchers/Omid-Bachari.jpg')

Meetup.create(name: 'Testing ActiveRecord', description: 'This is a test to make sure I know what whats going on', location: '53 Harrison Ave.')

Meetup.create(name: 'Testing multiple records', description: 'This is a test to make sure I know what whats going on', location: '53 Harrison Ave.')

Meetup.create(name: 'Does it add rows that are false', description: 'This is a test to make sure I know what whats going on', location: '53 Harrison Ave.')

UserMeetup.create(user_id: 1, meetup_id: 1)

UserMeetup.create(user_id: 4, meetup_id: 4)
UserMeetup.create(user_id: 5, meetup_id: 15)






Queries:
-Store user AlexMorgan as a variable:
alexm = User.where(username: "AlexMorgan").first

-Query all meetups that alexm is a part of & store
alex_meetings = alexm.user_meetups

alex_meetings = UserMeetup.where(user_id: alexm.id)

-Find the names of the meetings that Alex is attending

alexm.meetups

alexm.meetups.each { |meetup| puts meetup.name }

alex_meetings.each do |m|
  attending << Meetup.where(id: m.meetup_id)
end

attending.each do |m|
  m.name
end

