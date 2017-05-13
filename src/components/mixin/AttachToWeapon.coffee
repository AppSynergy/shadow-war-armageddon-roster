AttachToWeapon =
  
  methods:
    
    couldAttachTo: (weapon) ->
      _.filter @weapons, (x) ->
        _.contains weapon.only_attaches.values, x.role

    weaponAttaches: (weapon) ->
      _.has weapon, 'only_attaches'
    
  
export default AttachToWeapon
