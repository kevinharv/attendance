# Attendance

*Rapid attendance tracking for K-12 and Higher Education classrooms.*

## About

Enable the rapid and accurate recording of attendance for lectures, labs, and other types of classroom engagements. Analyze for patterns to shape policies and learning objectives. Measure student and instructor engagement with an actionable metric for better learning outcomes.

## Architecture

### Services

- User Service
    - Registration, authentication, authorization
    - Integrate with AWS Cognito?
    - Support Student, Instructor, Administrator personas

    PK - user ID
    Other info? Anything not stored in Cognito or Directory service?

    Cognito
    - Custom domain (w/ ACM cert via DNS)
    - Setup applications?
    - Configure API Gateway to use as authorizer


- Directory Service
    - Manage universities, colleges, classes, and sections - arbitrary groupings
    - Used to configure deployment for attendance taking
    - Manage memberships
- Attendance Service
    - Generate an ephemeral code for proving attendance
    - Validate geolocation data upon submission (opt-in feature)
    - Log attendance submissions of attendees
- (Later) Analytics Service
    - Show insights, trends and aggregates
    - Connect to data lakes

### Bootstrapping

1. Create University
1. Create colleges within University
1. Create courses within colleges
1. Create sections for each course
1. Create several users for each persona



## Data Schema Design

### Events
- attendance.attend.v1
    - user_id
    - occurrence_id
    - request_ipv4
    - request_lat
    - request_long
- attendance.courses.membership.v1
    - user_id
    - course_id
    - action (ADD/REMOVE)
    - role (requred for ADD)


### DynamoDB Tables

- Tenants
    - tenant_id
    - tenant_name

- Groups
    - group_id
    - group_name
    - parent_id

- Course
    - course_id
    - course_name
    - parent_id
    - instructor_id
    - members (JSON array of user IDs)

- Users
    - user_id
    - email
    - first_name
    - last_name
    - display_name
    - tenant_id
    - groups (JSON array of group IDs)
    - courses (JSON array of course IDs)