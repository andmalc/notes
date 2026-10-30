---
title: "Future Proof #6: How To Get More Accurate Results From Your AI Tools
source: "https://mail.google.com/mail/u/0/#inbox/FMfcgzQhWxWVzjxQxxGvmPKDHjFRwplh"
author: Ben Collins
published:
created: 2026-10-20
description: 
tags:
  - "clippings"
  - AI
---
## Future Proof #6: How To Get More Accurate Results From Your AI Tools

Future Proof Tip #6: Use Embedded Quality Assurance Checks To Improve Accuracy
Embedded Quality Assurance (QA) means building a check into your prompt so that the model verifies its output before returning the results.

It can dramatically improve the precision of results in certain scenarios.

Of course, not every prompt suddenly requires a QA clause. In fact, most don't.

But if you're dealing with data, calculations, or lots of assumptions, then it's a useful technique to save you time running extra prompts to check or fix these things.

Here's an example from my own work, when I needed a photo-realistic receipt for teaching purposes.

![alt text](Use%20Embedded%20Quality%20Assurance%20Checks%20-%20receipt.png)

Notice the QA check in the second paragraph:

"Ensure that all line items, subtotals, calculated taxes (if any, specified with a percentage), and totals are accurate, mathematically correct, and consistent throughout the text of the generated receipt."

This receipt was used to show how an AI tool can extract the data from an image and put it into a Google Sheet. So it was important that the receipt be mathematically accurate otherwise the demonstration would fall apart.

How To Add A QA Check
For situations involving data analysis, calculations, or factual claims, add a QA clause to the end of your prompt.

A QA clause is one or two extra sentences that ask the model to verify its figures and assumptions.

Be sure to include specific criteria and instructions rather than general vague statements like "make sure it works".

Example QA Checks

* Ensure that all line items, totals, and calculations are accurate, mathematically correct, and consistent throughout.
* For every claim, include the page or paragraph it came from. If you can’t find support for a claim, leave it out and flag it.
* Mark each statement as confident, likely or uncertain, and say what you’d need to verify the uncertain ones.
* Review your draft against these criteria: under 150 words, one clear ask, no jargon. Fix anything that fails and give me only the final version.

Pro Tip: If you're struggling to come up with a QA check, ask Gemini to add one to your prompt.

For example:

Before I run this prompt, add a short QA check line at the end.

My prompt: "Our revenue went from £100k to £200k in year one, then fell back to £100k in year two. What was the average annual growth rate?"

Gemini will then revise your prompt with a QA line included, which you can then use in a new chat:

"Our revenue went from £100k to £200k in year one, then fell back to £100k in year two. What was the average annual growth rate?

QA Check: Please show the step-by-step mathematical calculations for both the Arithmetic Mean and the Compound Annual Growth Rate (CAGR) before providing the final answer to verify that the math is correct."

![prompt example](Use%20Embedded%20Quality%20Assurance%20Checks%20-%20prompt_example.png)

Notes
This technique works great in any other LLM like Claude or ChatGPT too.
You do not need to add a QA check to every prompt! Only ones that would benefit from additional accuracy check.
If you enjoyed this newsletter, please forward it to a friend who might enjoy it.
