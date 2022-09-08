# Request Page Aggregated Data

Create a new Page Event

**URL** : `/page_events/total`

**Method** : `GET`

**Auth required** : NO

**Permissions required** : None

**Data constraints**

url: [required]
event_type: [required, can be `view` or `click`]
starts_at: [optional]
ends_at: [optional]

**starts_at** and **ends_at** can be anything that Ruby can parse with `Time.parse()`

**Data example** All fields must be sent.

```json
{
	"url": "https://example.com/page_one",
	"event_type": "view",
	"starts_at": "2022-09-08 10:00:00",
	"ends_at": "2022-09-08 11:00:00"
}
```

## Success Response

**Condition** : If everything is OK and events could be counted

**Code** : `200 OK`

**Response body example**

```json
{
	"events_count": 2
}
```

## Error Responses

**Condition** : If `event_type` is wrong

**Code** : `400 BAD REQUEST`

```json
{
	"message": "Argument 'event_type' must be one of the following: [\"view\", \"click\"]"
}
```

### Or

**Condition** : If fields are missed

**Code** : `400 BAD REQUEST`

**Response body example**

```json
{
	"message": "Argument 'event_type' is required"
}
```

### Or

**Condition** : If the record for the URL could not be found

**Code** : `404 NOT FOUND`

**Response body example**

```json
{
	"message": "Record not found"
}
```