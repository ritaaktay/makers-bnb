## Functionalities

* Can view listings without login 
* Login / Sign up (Offering User & Booking User)
* List new space (Offering User) 
* List multiple spaces (Offering User) 
* Name space (Offering User)
* Describe space (Offering User)
* Price per night (Offering User)
* Mark availability (Offering User) 
* Make requests (Booking User) 
* Approve requests - space owner (Offering User)
  * Mark space/date as unavailable once approved
  * Decline all pending request
* Decline requests (Offering User)
  * Mark as declined
  * Declined request persists


## Tables

## Users
- Id: serial primary key
- Email: text (unique)
- password : text
- Username: text (unique)

## Requests
- Id: serial primary key
- Date: date
- User_id: int foreign key
- Listing_id: int foreign key
- Status: enum (confirmed, declined, pending)

## Spaces
- Id: serial primary key
- Name: text
- Description: text
- User_id

## Listings
- Id: serial primary key
- Price_per_night: numeric
- Space_id:  int foreign key
- Availability: date array


## Routes
- Get ‘/’
- Get ‘/sessions/new’
- Get ‘/spaces
- Get ‘/spaces/new’
- Get ‘/spaces/:id’
- Get ’/requests’
- Get ’/requests/:id’

- Post ‘/users’
- Post ‘/spaces’
- Post ‘/requests’

- Patch ‘/requests/accepted’
- Patch ‘/requests/declined’
