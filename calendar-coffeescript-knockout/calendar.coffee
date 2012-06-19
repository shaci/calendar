CalendarViewModel = (options) ->
  self     = this
  calendar = null  
  months   = ["январь", "февраль", "март", "апрель", "май", "июнь", "июль", "август", "сентябрь", "октябрь","ноябрь" ,"декабрь"];  
  date     = null  

  init = ->
    parseDate options
    createCalendar()    

  parseDate = (value) -> 
    if value instanceof Date
      date = value
      date.setDate 1      
    else
      date = new Date options.year, options.month - 1      

  getDay = (date) ->
    day = date.getDay()
    day = 7 if !day
    day - 1

  createCalendar = ->
    calendar  = '<tr>'
    yearAfter = yearBefore = date.getFullYear()
    calendar  += '<td></td>' for [0...getDay(date)]
    month = date.getMonth()
    while date.getMonth() == month
      calendar += '<td>'+date.getDate()+'</td>'
      calendar += '</tr><tr>' if getDay(date) % 7 == 6
      date.setDate(date.getDate()+1)
    calendar += '<td></td>' for [getDay(date)...7] if getDay(date) != 0
    calendar += '</tr>'
    yearAfter = date.getFullYear()
    if yearAfter != yearBefore
      date.setFullYear(yearBefore, month, 1)
    else 
      date.setMonth(month, 1)
    

  self.prevMonth = ->
    month = date.getMonth()
    if month == 0
      date.setFullYear(date.getFullYear() - 1, 11, 1)
    else
      date.setMonth(date.getMonth() - 1, 1)
    createCalendar();
    self.calendar(calendar);
    self.date(months[date.getMonth()] + ' ' + (date.getYear() + 1900));
    

  self.nextMonth = ->
    month = date.getMonth()
    if month == 11
      date.setFullYear(date.getFullYear() + 1, 0, 1)
    else
      date.setMonth(date.getMonth() + 1, 1)
    createCalendar();
    self.calendar(calendar);
    self.date(months[date.getMonth()] + ' ' + (date.getYear() + 1900))
    
  init()
  self.calendar = ko.observable(calendar)
  self.date = ko.observable(months[date.getMonth()] + ' ' + (date.getYear() + 1900));  

ko.applyBindings new CalendarViewModel new Date