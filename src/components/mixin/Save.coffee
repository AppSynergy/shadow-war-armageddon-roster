
import Storage from './Storage.coffee'

Save =

  mixins: [Storage]

  data: () ->
    modalId: "unsavedRosterModal"
    modalOptions: [
      {name: 'discard', text: 'No thanks'}
      {name: 'save', text: 'Yes please'}
    ]
    discardAction: () -> null

  methods:

    processModalOption: (option) ->
      success = if option.name == 'save' then @saveRoster() else true
      jQuery('#' + @modalId).modal 'hide'
      if success
        @$store.commit 'discardRoster'
        @discardAction()

    saveRoster: () ->
      if @teamName.length > 0
        @event 'save_roster', @factionId
        @$store.commit 'cleanState'
        @saveRosterLocal
          fighters: @chosenFighters
          factionId: @factionId
          teamName: @teamName
        @cycleNotification { id: 'save', desc: 'Roster saved.', type: 'success' }
        return true
      else
        @cycleNotification { id: 'name', desc: 'You must give your team a name before it can be saved.', type: 'warning' }
        return false


export default Save
