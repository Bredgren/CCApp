# Attributes of Notifier:
#
# notifiee: functions[String]
#
class Notifier
  #notifieeCollection_: {}

  constructor: ->
    @notifieeCollection_ = {}

  notifieeIs: (attribute, callback) ->
    current = @notifieeCollection_[attribute]
    if current
      return if callback in current
      current.push(callback)
    else
      current = [callback]
    @notifieeCollection_[attribute] = current

  notify_: (attribute, args...) ->
    notifiees = @notifieeCollection_[attribute]
    return if not notifiees
    console.log("notifying for", attribute, "with args", args)
    for notifiee in notifiees
      notifiee(args)