
from pydantic import BaseModel, Field
from openai import OpenAI
from dotenv import load_dotenv
load_dotenv() 

client = OpenAI()

class CalendarEvent(BaseModel):
    name: str = Field(description = "The name of the event.")
    date: str = Field(description = "The date of the event.")
    participants: list[str] = Field(description = "A list of participants attending the event.")

CalendarEvent.model_json_schema()

completion = client.beta.chat.completions.parse(
    model="gpt-4o-mini",
    messages=[
        {"role": "system", "content": "Extract the event information."},
        {"role": "user", "content": "Alice and Bob are going to a science fair on Friday."},
    ],
    response_format = CalendarEvent
)

event = completion.choices[0].message.parsed
event.model_dump()

{'properties': {
    'name': {
        'description': 'The name of the event.',
        'title': 'Name',
        'type': 'string'
    },
    'date': {
        'description': 'The date of the event.',
        'title': 'Date',
        'type': 'string'
    },
    'participants': {
        'description': 'A list of participants attending the event.',
        'items': {'type': 'string'},
        'title': 'Participants',
        'type': 'array'
    }
},
 'required': ['name', 'date', 'participants'],
 'title': 'CalendarEvent',
 'type': 'object'}