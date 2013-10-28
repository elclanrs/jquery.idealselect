#
# Ideal Select
# @license MIT
# @author Cedric Ruiz
# @source https://github.com/elclanrs/jquery.idealselect
#
let $ = jQuery, doc = document, win = window
  (require \./plugin) do
    name: \idealselect
    methods:
      _init: ->
        @select$ = $ @el
        @select$
          .css position: \absolute, left: \-9999px
          .attr \tabindex -1
        @_build!

      _build: ->
        @options$ = @select$.find \option
        default$ = @options$.filter \:selected
        @items$ = $ do
          @options$
            .map -> "<li>#{$ @ .text!}</li>"
            .get!join ''
        @items$.eq default$.index! .add-class \selected
        @title$ = $ """
          <a href="#" class="title" tabindex="-1">
            <span>#{default$.text!}</span>
            <i/>
          </a>
        """
        @dropdown$ = $ '<ul class="dropdown"></ul>' .append @items$
        @idealselect$ = $ """
          <div class="idealselect" tabindex="0">
            <ul>
              <li></li>
            </ul>
          </div>
        """
        @select$.next \.idealselect .remove!
        @idealselect$
          ..find \li .append @title$, @dropdown$
          ..insert-after @select$
        @_events!

      _update: (index) ->
        @options$.eq index .prop \selected true
        @idealselect$.find '.title span' .text (@items$.eq index .text!)
        @items$.remove-class \selected .eq index .add-class \selected

      _scroll: (index) ->
        item$ = if index then @items$.eq index else @items$.filter \.selected
        height = @dropdown$.height!
        position = item$.position!top
        if position >= height
          item$.parent!.0.scroll-top = item$.0.offset-top - height + item$.height!
        if not index or position < 0
          item$.parent!.0.scroll-top = item$.0.offset-top

      _find: (letter) ->
        matches$ = @items$.filter -> ($ @ .text!index-of letter) is 0
        first = matches$.index!
        next = matches$.slice do
          (matches$.index matches$.filter \.selected) + 1
          matches$.length
        .index!
        if next > -1 then next else first

      _events: ->
        @select$.change (e) ~>
          @_update ($ e.target .find \:selected .index!)
        @title$.click (e) ~>
          e.prevent-default!
          @idealselect$.focus!toggle-class \open
          @_scroll!
        @items$.click (e) ~>
          @_update ($ e.target .index!)
          @idealselect$.remove-class \open
          @select$.change!
        @idealselect$
          .mousedown (.prevent-default!)
          .focus ~> @select$.trigger-handler \focus
          .blur ~>
            @idealselect$.remove-class \open
            @select$.blur!
          .keydown (e) ~>
            index = @options$.filter \:selected .index!
            switch e.which
              # Enter
              when 13 => @idealselect$.toggle-class \open
              # Arrows
              when 38 => index = index-1 if index-1 > -1
              when 40 => index = index+1 if index+1 < @items$.length
              # Letter
              else
                index = @_find String.from-char-code e.which
                scroll-now = true
            if index > -1
              @_update index
              @_scroll if scroll-now then 0 else index
              @select$.change!
            # Prevent window scroll
            $ doc .one \keydown (e) ->
              e.prevent-default! if e.which is 38 or e.which is 40
