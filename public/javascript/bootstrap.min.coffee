not (a) ->
  a ->
    "use strict"
    a.support.transition = ->
      a = ->
        a = document.createElement("bootstrap")
        b =
          WebkitTransition: "webkitTransitionEnd"
          MozTransition: "transitionend"
          OTransition: "oTransitionEnd"
          msTransition: "MSTransitionEnd"
          transition: "transitionend"

        c = undefined
        for c of b
          return b[c]  if a.style[c] isnt `undefined`
      ()
      a and end: a
    ()
(window.jQuery)
not (a) ->
  "use strict"
  b = "[data-dismiss=\"alert\"]"
  c = (c) ->
    a(c).on "click", b, @close

  c::close = (b) ->
    f = ->
      e.trigger("closed").remove()
    c = a(this)
    d = c.attr("data-target")
    e = undefined
    d or (d = c.attr("href")
    d = d and d.replace(/.*(?=#[^\s]*$)/, "")
    )
    e = a(d)
    b and b.preventDefault()
    e.length or (e = (if c.hasClass("alert") then c else c.parent()))
    e.trigger(b = a.Event("close"))

    return  if b.isDefaultPrevented()
    e.removeClass("in")
    (if a.support.transition and e.hasClass("fade") then e.on(a.support.transition.end, f) else f())

  a.fn.alert = (b) ->
    @each ->
      d = a(this)
      e = d.data("alert")
      e or d.data("alert", e = new c(this))
      typeof b is "string" and e[b].call(d)

  a.fn.alert.Constructor = c
  a(->
    a("body").on "click.alert.data-api", b, c::close
  )
(window.jQuery)
not (a) ->
  "use strict"
  b = (b, c) ->
    @$element = a(b)
    @options = a.extend({}, a.fn.button.defaults, c)

  b::setState = (a) ->
    b = "disabled"
    c = @$element
    d = c.data()
    e = (if c.is("input") then "val" else "html")
    a += "Text"
    d.resetText or c.data("resetText", c[e]())
    c[e](d[a] or @options[a])
    setTimeout(->
      (if a is "loadingText" then c.addClass(b).attr(b, b) else c.removeClass(b).removeAttr(b))
    , 0)

  b::toggle = ->
    a = @$element.parent("[data-toggle=\"buttons-radio\"]")
    a and a.find(".active").removeClass("active")
    @$element.toggleClass("active")

  a.fn.button = (c) ->
    @each ->
      d = a(this)
      e = d.data("button")
      f = typeof c is "object" and c
      e or d.data("button", e = new b(this, f))
      (if c is "toggle" then e.toggle() else c and e.setState(c))

  a.fn.button.defaults = loadingText: "loading..."
  a.fn.button.Constructor = b
  a(->
    a("body").on "click.button.data-api", "[data-toggle^=button]", (b) ->
      c = a(b.target)
      c.hasClass("btn") or (c = c.closest(".btn"))
      c.button("toggle")
  )
(window.jQuery)
not (a) ->
  "use strict"
  b = (b, c) ->
    @$element = a(b)
    @options = c
    @options.slide and @slide(@options.slide)
    @options.pause is "hover" and @$element.on("mouseenter", a.proxy(@pause, this)).on("mouseleave", a.proxy(@cycle, this))

  b:: =
    cycle: (b) ->
      b or (@paused = not 1)
      @options.interval and not @paused and (@interval = setInterval(a.proxy(@next, this), @options.interval))
      this

    to: (b) ->
      c = @$element.find(".active")
      d = c.parent().children()
      e = d.index(c)
      f = this
      return  if b > d.length - 1 or b < 0
      (if @sliding then @$element.one("slid", ->
        f.to b
      ) else (if e is b then @pause().cycle() else @slide((if b > e then "next" else "prev"), a(d[b]))))

    pause: (a) ->
      a or (@paused = not 0)
      clearInterval(@interval)
      @interval = null
      this

    next: ->
      return  if @sliding
      @slide "next"

    prev: ->
      return  if @sliding
      @slide "prev"

    slide: (b, c) ->
      d = @$element.find(".active")
      e = c or d[b]()
      f = @interval
      g = (if b is "next" then "left" else "right")
      h = (if b is "next" then "first" else "last")
      i = this
      j = a.Event("slide")
      @sliding = not 0
      f and @pause()
      e = (if e.length then e else @$element.find(".item")[h]())

      return  if e.hasClass("active")
      if a.support.transition and @$element.hasClass("slide")
        @$element.trigger j
        return  if j.isDefaultPrevented()
        e.addClass(b)
        e[0].offsetWidth
        d.addClass(g)
        e.addClass(g)
        @$element.one(a.support.transition.end, ->
          e.removeClass([ b, g ].join(" ")).addClass("active")
          d.removeClass([ "active", g ].join(" "))
          i.sliding = not 1
          setTimeout(->
            i.$element.trigger "slid"
          , 0)
        )
      else
        @$element.trigger j
        return  if j.isDefaultPrevented()
        d.removeClass("active")
        e.addClass("active")
        @sliding = not 1
        @$element.trigger("slid")
      f and @cycle()
      this

  a.fn.carousel = (c) ->
    @each ->
      d = a(this)
      e = d.data("carousel")
      f = a.extend({}, a.fn.carousel.defaults, typeof c is "object" and c)
      e or d.data("carousel", e = new b(this, f))
      (if typeof c is "number" then e.to(c) else (if typeof c is "string" or (c = f.slide) then e[c]() else f.interval and e.cycle()))

  a.fn.carousel.defaults =
    interval: 5e3
    pause: "hover"

  a.fn.carousel.Constructor = b
  a(->
    a("body").on "click.carousel.data-api", "[data-slide]", (b) ->
      c = a(this)
      d = undefined
      e = a(c.attr("data-target") or (d = c.attr("href")) and d.replace(/.*(?=#[^\s]+$)/, ""))
      f = not e.data("modal") and a.extend({}, e.data(), c.data())
      e.carousel(f)
      b.preventDefault()
  )
(window.jQuery)
not (a) ->
  "use strict"
  b = (b, c) ->
    @$element = a(b)
    @options = a.extend({}, a.fn.collapse.defaults, c)
    @options.parent and (@$parent = a(@options.parent))
    @options.toggle and @toggle()

  b:: =
    constructor: b
    dimension: ->
      a = @$element.hasClass("width")
      (if a then "width" else "height")

    show: ->
      b = undefined
      c = undefined
      d = undefined
      e = undefined
      return  if @transitioning
      b = @dimension()
      c = a.camelCase([ "scroll", b ].join("-"))
      d = @$parent and @$parent.find("> .accordion-group > .in")

      if d and d.length
        e = d.data("collapse")
        return  if e and e.transitioning
        d.collapse("hide")
        e or d.data("collapse", null)
      @$element[b](0)
      @transition("addClass", a.Event("show"), "shown")
      @$element[b](@$element[0][c])

    hide: ->
      b = undefined
      return  if @transitioning
      b = @dimension()
      @reset(@$element[b]())
      @transition("removeClass", a.Event("hide"), "hidden")
      @$element[b](0)

    reset: (a) ->
      b = @dimension()
      @$element.removeClass("collapse")[b](a or "auto")[0].offsetWidth
      @$element[(if a isnt null then "addClass" else "removeClass")]("collapse")
      this

    transition: (b, c, d) ->
      e = this
      f = ->
        c.type is "show" and e.reset()
        e.transitioning = 0
        e.$element.trigger(d)

      @$element.trigger c
      return  if c.isDefaultPrevented()
      @transitioning = 1
      @$element[b]("in")
      (if a.support.transition and @$element.hasClass("collapse") then @$element.one(a.support.transition.end, f) else f())

    toggle: ->
      this[(if @$element.hasClass("in") then "hide" else "show")]()

  a.fn.collapse = (c) ->
    @each ->
      d = a(this)
      e = d.data("collapse")
      f = typeof c is "object" and c
      e or d.data("collapse", e = new b(this, f))
      typeof c is "string" and e[c]()

  a.fn.collapse.defaults = toggle: not 0
  a.fn.collapse.Constructor = b
  a(->
    a("body").on "click.collapse.data-api", "[data-toggle=collapse]", (b) ->
      c = a(this)
      d = undefined
      e = c.attr("data-target") or b.preventDefault() or (d = c.attr("href")) and d.replace(/.*(?=#[^\s]+$)/, "")
      f = (if a(e).data("collapse") then "toggle" else c.data())
      a(e).collapse f
  )
(window.jQuery)
not (a) ->
  d = ->
    a(b).parent().removeClass "open"
  "use strict"
  b = "[data-toggle=\"dropdown\"]"
  c = (b) ->
    c = a(b).on("click.dropdown.data-api", @toggle)
    a("html").on "click.dropdown.data-api", ->
      c.parent().removeClass "open"

  c:: =
    constructor: c
    toggle: (b) ->
      c = a(this)
      e = undefined
      f = undefined
      g = undefined
      return  if c.is(".disabled, :disabled")
      f = c.attr("data-target")
      f or (f = c.attr("href")
      f = f and f.replace(/.*(?=#[^\s]*$)/, "")
      )
      e = a(f)
      e.length or (e = c.parent())
      g = e.hasClass("open")
      d()
      g or e.toggleClass("open")
      not 1

  a.fn.dropdown = (b) ->
    @each ->
      d = a(this)
      e = d.data("dropdown")
      e or d.data("dropdown", e = new c(this))
      typeof b is "string" and e[b].call(d)

  a.fn.dropdown.Constructor = c
  a(->
    a("html").on("click.dropdown.data-api", d)
    a("body").on("click.dropdown", ".dropdown form", (a) ->
      a.stopPropagation()
    ).on("click.dropdown.data-api", b, c::toggle)
  )
(window.jQuery)
not (a) ->
  c = ->
    b = this
    c = setTimeout(->
      b.$element.off(a.support.transition.end)
      d.call(b)
    , 500)
    @$element.one a.support.transition.end, ->
      clearTimeout(c)
      d.call(b)
  d = (a) ->
    @$element.hide().trigger("hidden")
    e.call(this)
  e = (b) ->
    c = this
    d = (if @$element.hasClass("fade") then "fade" else "")
    if @isShown and @options.backdrop
      e = a.support.transition and d
      @$backdrop = a("<div class=\"modal-backdrop " + d + "\" />").appendTo(document.body)
      @options.backdrop isnt "static" and @$backdrop.click(a.proxy(@hide, this))
      e and @$backdrop[0].offsetWidth
      @$backdrop.addClass("in")
      (if e then @$backdrop.one(a.support.transition.end, b) else b())
    else
      (if not @isShown and @$backdrop then (@$backdrop.removeClass("in")
      (if a.support.transition and @$element.hasClass("fade") then @$backdrop.one(a.support.transition.end, a.proxy(f, this)) else f.call(this))
      ) else b and b())
  f = ->
    @$backdrop.remove()
    @$backdrop = null
  g = ->
    b = this
    (if @isShown and @options.keyboard then a(document).on("keyup.dismiss.modal", (a) ->
      a.which is 27 and b.hide()
    ) else @isShown or a(document).off("keyup.dismiss.modal"))
  "use strict"
  b = (b, c) ->
    @options = c
    @$element = a(b).delegate("[data-dismiss=\"modal\"]", "click.dismiss.modal", a.proxy(@hide, this))

  b:: =
    constructor: b
    toggle: ->
      this[(if @isShown then "hide" else "show")]()

    show: ->
      b = this
      c = a.Event("show")
      @$element.trigger c
      return  if @isShown or c.isDefaultPrevented()
      a("body").addClass("modal-open")
      @isShown = not 0
      g.call(this)
      e.call(this, ->
        c = a.support.transition and b.$element.hasClass("fade")
        b.$element.parent().length or b.$element.appendTo(document.body)
        b.$element.show()
        c and b.$element[0].offsetWidth
        b.$element.addClass("in")
        (if c then b.$element.one(a.support.transition.end, ->
          b.$element.trigger "shown"
        ) else b.$element.trigger("shown"))
      )

    hide: (b) ->
      b and b.preventDefault()
      e = this
      b = a.Event("hide")
      @$element.trigger(b)

      return  if not @isShown or b.isDefaultPrevented()
      @isShown = not 1
      a("body").removeClass("modal-open")
      g.call(this)
      @$element.removeClass("in")
      (if a.support.transition and @$element.hasClass("fade") then c.call(this) else d.call(this))

  a.fn.modal = (c) ->
    @each ->
      d = a(this)
      e = d.data("modal")
      f = a.extend({}, a.fn.modal.defaults, d.data(), typeof c is "object" and c)
      e or d.data("modal", e = new b(this, f))
      (if typeof c is "string" then e[c]() else f.show and e.show())

  a.fn.modal.defaults =
    backdrop: not 0
    keyboard: not 0
    show: not 0

  a.fn.modal.Constructor = b
  a(->
    a("body").on "click.modal.data-api", "[data-toggle=\"modal\"]", (b) ->
      c = a(this)
      d = undefined
      e = a(c.attr("data-target") or (d = c.attr("href")) and d.replace(/.*(?=#[^\s]+$)/, ""))
      f = (if e.data("modal") then "toggle" else a.extend({}, e.data(), c.data()))
      b.preventDefault()
      e.modal(f)
  )
(window.jQuery)
not (a) ->
  "use strict"
  b = (a, b) ->
    @init "tooltip", a, b

  b:: =
    constructor: b
    init: (b, c, d) ->
      e = undefined
      f = undefined
      @type = b
      @$element = a(c)
      @options = @getOptions(d)
      @enabled = not 0
      @options.trigger isnt "manual" and (e = (if @options.trigger is "hover" then "mouseenter" else "focus")
      f = (if @options.trigger is "hover" then "mouseleave" else "blur")
      @$element.on(e, @options.selector, a.proxy(@enter, this))
      @$element.on(f, @options.selector, a.proxy(@leave, this))
      )
      (if @options.selector then @_options = a.extend({}, @options,
        trigger: "manual"
        selector: ""
      ) else @fixTitle())

    getOptions: (b) ->
      b = a.extend({}, a.fn[@type].defaults, b, @$element.data())
      b.delay and typeof b.delay is "number" and (b.delay =
        show: b.delay
        hide: b.delay
      )
      b

    enter: (b) ->
      c = a(b.currentTarget)[@type](@_options).data(@type)
      return c.show()  if not c.options.delay or not c.options.delay.show
      clearTimeout(@timeout)
      c.hoverState = "in"
      @timeout = setTimeout(->
        c.hoverState is "in" and c.show()
      , c.options.delay.show)

    leave: (b) ->
      c = a(b.currentTarget)[@type](@_options).data(@type)
      return c.hide()  if not c.options.delay or not c.options.delay.hide
      clearTimeout(@timeout)
      c.hoverState = "out"
      @timeout = setTimeout(->
        c.hoverState is "out" and c.hide()
      , c.options.delay.hide)

    show: ->
      a = undefined
      b = undefined
      c = undefined
      d = undefined
      e = undefined
      f = undefined
      g = undefined
      if @hasContent() and @enabled
        a = @tip()
        @setContent()
        @options.animation and a.addClass("fade")
        f = (if typeof @options.placement is "function" then @options.placement.call(this, a[0], @$element[0]) else @options.placement)
        b = /in/.test(f)
        a.remove().css(
          top: 0
          left: 0
          display: "block"
        ).appendTo((if b then @$element else document.body))
        c = @getPosition(b)
        d = a[0].offsetWidth
        e = a[0].offsetHeight

        switch (if b then f.split(" ")[1] else f)
          when "bottom"
            g =
              top: c.top + c.height
              left: c.left + c.width / 2 - d / 2
          when "top"
            g =
              top: c.top - e
              left: c.left + c.width / 2 - d / 2
          when "left"
            g =
              top: c.top + c.height / 2 - e / 2
              left: c.left - d
          when "right"
            g =
              top: c.top + c.height / 2 - e / 2
              left: c.left + c.width
        a.css(g).addClass(f).addClass "in"

    isHTML: (a) ->
      typeof a isnt "string" or a.charAt(0) is "<" and a.charAt(a.length - 1) is ">" and a.length >= 3 or /^(?:[^<]*<[\w\W]+>[^>]*$)/.exec(a)

    setContent: ->
      a = @tip()
      b = @getTitle()
      a.find(".tooltip-inner")[(if @isHTML(b) then "html" else "text")](b)
      a.removeClass("fade in top bottom left right")

    hide: ->
      d = ->
        b = setTimeout(->
          c.off(a.support.transition.end).remove()
        , 500)
        c.one a.support.transition.end, ->
          clearTimeout(b)
          c.remove()
      b = this
      c = @tip()
      c.removeClass("in")
      (if a.support.transition and @$tip.hasClass("fade") then d() else c.remove())

    fixTitle: ->
      a = @$element
      (a.attr("title") or typeof a.attr("data-original-title") isnt "string") and a.attr("data-original-title", a.attr("title") or "").removeAttr("title")

    hasContent: ->
      @getTitle()

    getPosition: (b) ->
      a.extend {}, (if b then
        top: 0
        left: 0
       else @$element.offset()),
        width: @$element[0].offsetWidth
        height: @$element[0].offsetHeight

    getTitle: ->
      a = undefined
      b = @$element
      c = @options
      a = b.attr("data-original-title") or (if typeof c.title is "function" then c.title.call(b[0]) else c.title)
      a

    tip: ->
      @$tip = @$tip or a(@options.template)

    validate: ->
      @$element[0].parentNode or (@hide()
      @$element = null
      @options = null
      )

    enable: ->
      @enabled = not 0

    disable: ->
      @enabled = not 1

    toggleEnabled: ->
      @enabled = not @enabled

    toggle: ->
      this[(if @tip().hasClass("in") then "hide" else "show")]()

  a.fn.tooltip = (c) ->
    @each ->
      d = a(this)
      e = d.data("tooltip")
      f = typeof c is "object" and c
      e or d.data("tooltip", e = new b(this, f))
      typeof c is "string" and e[c]()

  a.fn.tooltip.Constructor = b
  a.fn.tooltip.defaults =
    animation: not 0
    placement: "top"
    selector: not 1
    template: "<div class=\"tooltip\"><div class=\"tooltip-arrow\"></div><div class=\"tooltip-inner\"></div></div>"
    trigger: "hover"
    title: ""
    delay: 0
(window.jQuery)
not (a) ->
  "use strict"
  b = (a, b) ->
    @init "popover", a, b

  b:: = a.extend({}, a.fn.tooltip.Constructor::,
    constructor: b
    setContent: ->
      a = @tip()
      b = @getTitle()
      c = @getContent()
      a.find(".popover-title")[(if @isHTML(b) then "html" else "text")](b)
      a.find(".popover-content > *")[(if @isHTML(c) then "html" else "text")](c)
      a.removeClass("fade top bottom left right in")

    hasContent: ->
      @getTitle() or @getContent()

    getContent: ->
      a = undefined
      b = @$element
      c = @options
      a = b.attr("data-content") or (if typeof c.content is "function" then c.content.call(b[0]) else c.content)
      a

    tip: ->
      @$tip or (@$tip = a(@options.template))
      @$tip
  )
  a.fn.popover = (c) ->
    @each ->
      d = a(this)
      e = d.data("popover")
      f = typeof c is "object" and c
      e or d.data("popover", e = new b(this, f))
      typeof c is "string" and e[c]()

  a.fn.popover.Constructor = b
  a.fn.popover.defaults = a.extend({}, a.fn.tooltip.defaults,
    placement: "right"
    content: ""
    template: "<div class=\"popover\"><div class=\"arrow\"></div><div class=\"popover-inner\"><h3 class=\"popover-title\"></h3><div class=\"popover-content\"><p></p></div></div></div>"
  )
(window.jQuery)
not (a) ->
  b = (b, c) ->
    d = a.proxy(@process, this)
    e = (if a(b).is("body") then a(window) else a(b))
    f = undefined
    @options = a.extend({}, a.fn.scrollspy.defaults, c)
    @$scrollElement = e.on("scroll.scroll.data-api", d)
    @selector = (@options.target or (f = a(b).attr("href")) and f.replace(/.*(?=#[^\s]+$)/, "") or "") + " .nav li > a"
    @$body = a("body")
    @refresh()
    @process()
  "use strict"
  b:: =
    constructor: b
    refresh: ->
      b = this
      c = undefined
      @offsets = a([])
      @targets = a([])
      c = @$body.find(@selector).map(->
        b = a(this)
        c = b.data("target") or b.attr("href")
        d = /^#\w/.test(c) and a(c)
        d and c.length and [ [ d.position().top, c ] ] or null
      ).sort((a, b) ->
        a[0] - b[0]
      ).each(->
        b.offsets.push(this[0])
        b.targets.push(this[1])
      )

    process: ->
      a = @$scrollElement.scrollTop() + @options.offset
      b = @$scrollElement[0].scrollHeight or @$body[0].scrollHeight
      c = b - @$scrollElement.height()
      d = @offsets
      e = @targets
      f = @activeTarget
      g = undefined
      return f isnt (g = e.last()[0]) and @activate(g)  if a >= c
      g = d.length
      while g--
        f isnt e[g] and a >= d[g] and (not d[g + 1] or a <= d[g + 1]) and @activate(e[g])

    activate: (b) ->
      c = undefined
      d = undefined
      @activeTarget = b
      a(@selector).parent(".active").removeClass("active")
      d = @selector + "[data-target=\"" + b + "\"]," + @selector + "[href=\"" + b + "\"]"
      c = a(d).parent("li").addClass("active")
      c.parent(".dropdown-menu") and (c = c.closest("li.dropdown").addClass("active"))
      c.trigger("activate")

  a.fn.scrollspy = (c) ->
    @each ->
      d = a(this)
      e = d.data("scrollspy")
      f = typeof c is "object" and c
      e or d.data("scrollspy", e = new b(this, f))
      typeof c is "string" and e[c]()

  a.fn.scrollspy.Constructor = b
  a.fn.scrollspy.defaults = offset: 10
  a(->
    a("[data-spy=\"scroll\"]").each ->
      b = a(this)
      b.scrollspy b.data()
  )
(window.jQuery)
not (a) ->
  "use strict"
  b = (b) ->
    @element = a(b)

  b:: =
    constructor: b
    show: ->
      b = @element
      c = b.closest("ul:not(.dropdown-menu)")
      d = b.attr("data-target")
      e = undefined
      f = undefined
      g = undefined
      d or (d = b.attr("href")
      d = d and d.replace(/.*(?=#[^\s]*$)/, "")
      )
      return  if b.parent("li").hasClass("active")
      e = c.find(".active a").last()[0]
      g = a.Event("show",
        relatedTarget: e
      )
      b.trigger(g)

      return  if g.isDefaultPrevented()
      f = a(d)
      @activate(b.parent("li"), c)
      @activate(f, f.parent(), ->
        b.trigger
          type: "shown"
          relatedTarget: e
      )

    activate: (b, c, d) ->
      g = ->
        e.removeClass("active").find("> .dropdown-menu > .active").removeClass("active")
        b.addClass("active")
        (if f then (b[0].offsetWidth
        b.addClass("in")
        ) else b.removeClass("fade"))
        b.parent(".dropdown-menu") and b.closest("li.dropdown").addClass("active")
        d and d()
      e = c.find("> .active")
      f = d and a.support.transition and e.hasClass("fade")
      (if f then e.one(a.support.transition.end, g) else g())
      e.removeClass("in")

  a.fn.tab = (c) ->
    @each ->
      d = a(this)
      e = d.data("tab")
      e or d.data("tab", e = new b(this))
      typeof c is "string" and e[c]()

  a.fn.tab.Constructor = b
  a(->
    a("body").on "click.tab.data-api", "[data-toggle=\"tab\"], [data-toggle=\"pill\"]", (b) ->
      b.preventDefault()
      a(this).tab("show")
  )
(window.jQuery)
not (a) ->
  "use strict"
  b = (b, c) ->
    @$element = a(b)
    @options = a.extend({}, a.fn.typeahead.defaults, c)
    @matcher = @options.matcher or @matcher
    @sorter = @options.sorter or @sorter
    @highlighter = @options.highlighter or @highlighter
    @updater = @options.updater or @updater
    @$menu = a(@options.menu).appendTo("body")
    @source = @options.source
    @shown = not 1
    @listen()

  b:: =
    constructor: b
    select: ->
      a = @$menu.find(".active").attr("data-value")
      @$element.val(@updater(a)).change()
      @hide()

    updater: (a) ->
      a

    show: ->
      b = a.extend({}, @$element.offset(),
        height: @$element[0].offsetHeight
      )
      @$menu.css(
        top: b.top + b.height
        left: b.left
      )
      @$menu.show()
      @shown = not 0
      this

    hide: ->
      @$menu.hide()
      @shown = not 1
      this

    lookup: (b) ->
      c = this
      d = undefined
      e = undefined
      @query = @$element.val()
      (if @query then (d = a.grep(@source, (a) ->
        c.matcher a
      )
      d = @sorter(d)
      (if d.length then @render(d.slice(0, @options.items)).show() else (if @shown then @hide() else this))
      ) else (if @shown then @hide() else this))

    matcher: (a) ->
      ~a.toLowerCase().indexOf(@query.toLowerCase())

    sorter: (a) ->
      b = []
      c = []
      d = []
      e = undefined
      (if e.toLowerCase().indexOf(@query.toLowerCase()) then (if ~e.indexOf(@query) then c.push(e) else d.push(e)) else b.push(e))  while e = a.shift()
      b.concat c, d

    highlighter: (a) ->
      b = @query.replace(/[\-\[\]{}()*+?.,\\\^$|#\s]/g, "\\$&")
      a.replace new RegExp("(" + b + ")", "ig"), (a, b) ->
        "<strong>" + b + "</strong>"

    render: (b) ->
      c = this
      b = a(b).map((b, d) ->
        b = a(c.options.item).attr("data-value", d)
        b.find("a").html(c.highlighter(d))
        b[0]
      )
      b.first().addClass("active")
      @$menu.html(b)
      this

    next: (b) ->
      c = @$menu.find(".active").removeClass("active")
      d = c.next()
      d.length or (d = a(@$menu.find("li")[0]))
      d.addClass("active")

    prev: (a) ->
      b = @$menu.find(".active").removeClass("active")
      c = b.prev()
      c.length or (c = @$menu.find("li").last())
      c.addClass("active")

    listen: ->
      @$element.on("blur", a.proxy(@blur, this)).on("keypress", a.proxy(@keypress, this)).on("keyup", a.proxy(@keyup, this))
      (a.browser.webkit or a.browser.msie) and @$element.on("keydown", a.proxy(@keypress, this))
      @$menu.on("click", a.proxy(@click, this)).on("mouseenter", "li", a.proxy(@mouseenter, this))

    keyup: (a) ->
      switch a.keyCode
        when 40, 38
      , 9
      , 13
          return  unless @shown
          @select()
        when 27
          return  unless @shown
          @hide()
        else
          @lookup()
      a.stopPropagation()
      a.preventDefault()

    keypress: (a) ->
      return  unless @shown
      switch a.keyCode
        when 9, 13
      , 27
          a.preventDefault()
        when 38
          break  unless a.type is "keydown"
          a.preventDefault()
          @prev()
        when 40
          break  unless a.type is "keydown"
          a.preventDefault()
          @next()
      a.stopPropagation()

    blur: (a) ->
      b = this
      setTimeout (->
        b.hide()
      ), 150

    click: (a) ->
      a.stopPropagation()
      a.preventDefault()
      @select()

    mouseenter: (b) ->
      @$menu.find(".active").removeClass("active")
      a(b.currentTarget).addClass("active")

  a.fn.typeahead = (c) ->
    @each ->
      d = a(this)
      e = d.data("typeahead")
      f = typeof c is "object" and c
      e or d.data("typeahead", e = new b(this, f))
      typeof c is "string" and e[c]()

  a.fn.typeahead.defaults =
    source: []
    items: 8
    menu: "<ul class=\"typeahead dropdown-menu\"></ul>"
    item: "<li><a href=\"#\"></a></li>"

  a.fn.typeahead.Constructor = b
  a(->
    a("body").on "focus.typeahead.data-api", "[data-provide=\"typeahead\"]", (b) ->
      c = a(this)
      return  if c.data("typeahead")
      b.preventDefault()
      c.typeahead(c.data())
  )
(window.jQuery)
