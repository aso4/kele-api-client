# Kele API Client

## Overview

A Ruby Gem API client to access the Bloc API, providing easy access to and use of [the student endpoints of Bloc's API](http://docs.blocapi.apiary.io/). Students can get their user and enrollment info, check their mentor’s availability, see their course roadmaps, and even submit their assignments through the command line. This Gem also offers the ability to read, send, and receive messages. All data is parsed and neatly formatted from JSON to Ruby hash.

### Usage

With a valid Bloc username and password, use the kele API to access user information.

* Authenticate and retrieve user token using `Kele.new(username, password)`.
* Retrieve authenticated user's information.
```
  kele_instance = Kele.new(username, password)
  kele_instance.get_me
```
* Retrieve mentor availability for authenticated user.
```
  kele_instance = Kele.new(username, password)
  kele_instance.get_mentor_availability(mentor_id)
```
* Retrieve authenticated user's curriculum roadmaps and checkpoints.
```
  kele_instance = Kele.new(username, password)
  kele_instance.get_roadmap(roadmap_id)
  kele_instance.get_checkpoint(checkpoint_id)
```
* Retrieve and send authenticated user's messages.
```
  kele_instance = Kele.new(username, password)
  kele_instance.get_messages(page)
  # If appending a message to an existing message thread, include the thread token. Otherwise, leave token blank.
  kele_instance.create_message(user_id, recipient_id, subject, message, token)
```
* Create and update authenticated user's submissions.
```
  kele_instance = Kele.new(username, password)
  kele_instance.create_submission(checkpoint_id, assignment_branch, assignment_commit_link, comment, enrollment_id)
  kele_instance.update_submission(submission_id, checkpoint_id, assignment_branch, assignment_commit_link, comment, enrollment_id)
```