# ponoconnect
24/7 voice help for the homeless on Oahu. For details please see [the hackathon slide presentation](https://bit.ly/ponoconnect).

#### Try it: [on Vapi.ai](https://vapi.ai?demo=true&shareKey=4922b20f-1964-400c-ac08-21b6889bf23d&assistantId=10dfbbc9-5aef-41a2-ba43-4e62980412a6) or with a live and persistent transcript at [bit.ly/oahuhelp](https://bit.ly/oahuhelp)

<a href=https://bit.ly/oahuhelp><img src=screenshot.png width=600 /></a>

#### If both of those are unresponsive, it's probably because the billing limits are exceeded. You can create a trial account with $10 in free credits on [dashboard.vapi.ai](https://dashboard.vapi.ai/) and copy the settings below into "Create Assistant" / "Blank Template":

The First Message is: Greetings, this is the Oahu emergency housing locator. How may I help you?

The System Prompt is in [system-prompt.txt](system-prompt.txt) which uses several a one- and two-shot examples. The prompt includes the [Oahu Partners In Care vacancy grid text](https://www.partnersincareoahu.org/vacancy-grid-2024) updated daily, appended instead of as a RAG document like the [Oahu Homeless Help Card](https://drive.google.com/file/d/1ThtgjkUWro2yLxYI_fguvgwv72V9WAwq) and the [resources database](https://docs.google.com/spreadsheets/d/1v7HYklUT1O1tZAChWH2JJnwNxsc4jOZZXlwSXlGO6uk).

Max Tokens: 200

Detect emotion: On

<a href=https://bit.ly/ponoconnect><img src=slide.png width=600 /></a>

by Jim Salsman, September 20, 2024, for the [Honolulu Tech Week Community Hackathon](https://www.honolulutechweek.com/hackathon)

License: MIT

<a href="https://acrobat.adobe.com/id/urn:aaid:sc:US:09696fca-7253-4e69-bfa6-6acedaa5ef90"><img src=trends.png width=600 /><br/>Unsheltered homeless on Oahu have doubled over the past twelve years.</a>
