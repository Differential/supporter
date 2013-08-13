Handlebars.registerHelper "pluralize", (offerCount) -> 
  if offerCount == 1 
    return offerCount + " response"
  else
    return offerCount + " responses"