# Register Page Event

Create a new Page Event

**URL** : `/page_events/`

**Method** : `POST`

**Auth required** : NO

**Permissions required** : None

**Data constraints**

url: [required]
ip: [required]
event_type: [required, can be `view` or `click`]

**Data example** All fields must be sent.

```json
{
	"url": "https://example.com/page_one",
	"ip": "127.0.0.1",
	"event_type": "view"
}
```

## Success Response

**Condition** : If everything is OK and Page Event was registered

**Code** : `200 OK`

**Response body example**

```json
{
	"status": "OK"
}
```

## Error Responses

**Condition** : If `event_type` is wrong

**Code** : `400 BAD REQUEST`

```json
{
	"message": "'wrong' is not a valid event_type"
}
```

### Or

**Condition** : If fields are missed

**Code** : `400 BAD REQUEST`

**Response body example**

```json
{
	"message": "Validation failed: Ip can't be blank"
}
```