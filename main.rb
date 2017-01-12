Object = {
  init = {
    { cls = cls! }.update( args! )
  }
}

Car =!@ {
  init =!@ {
    cls!.super_cls!.init(args =!@ {maker =!@ maker!})
  }

  super_cls =!@ Object
  wheels =!@ 4
}

Car!.wheels # => 4
c =!@ Car!.init(cls =!@ Car!, maker =!@ 'honda') # => {maker =!@ 'honda', **Car}
c.maker  # => 'honda'
c.wheels # => 4

















