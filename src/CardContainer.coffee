#  Project: jQuery Card container
#  Description: A jQuery plugin that allows to create simple wizard using a div acting like a Swing "CardLayout"
#  Author: Mathieu, Alexandre
#  License: MIT

# Note that when compiling with coffeescript, the plugin is wrapped in another
# anonymous function. We do not need to pass in undefined as well, since
# coffeescript uses (void 0) instead.
(($, window) ->
	# window is passed through as local variable rather than global
	# as this (slightly) quickens the resolution process and can be more efficiently
	# minified (especially when both are regularly referenced in your plugin).

	# Create the defaults once
	pluginName = 'cardcontainer'
	document = window.document
	defaults =
		property: 'value'

	# The actual plugin constructor
	class CardContainer
		constructor: (@containerElement, options) ->
			# jQuery has an extend method which merges the contents of two or
			# more objects, storing the result in the first object. The first object
			# is generally empty as we don't want to alter the default options for
			# future instances of the plugin
			@options = $.extend {}, defaults, options

			@_defaults = defaults
			@_name = pluginName

			@init()

		init: ->
			# Place initialization logic here
			# You already have access to the DOM element and the options via the instance,
			# e.g., @element and @options
			$('[card-index]',@containerElement).hide()
			$("[card-index='0']",@containerElement).show()
			@currentIndex = 0

			#$('[card-change]',@containerElement).on 'click', (event)=>
			$(@containerElement).on 'click.card-container', "[card-change]", (event)=>
				switch $(event.target).attr('card-change')
					when "next" then @next()
					when "previous" then @previous()
					else 
						if not isNaN($(event.target).attr('card-change')-0) # it is a number
							@changeCard($(event.target).attr('card-change'))

		next: ->
			@changeCard @currentIndex+1

		previous: ->
			@changeCard @currentIndex-1

		first: ->
			@changeCard 0

		changeCard: (newIndex) ->
			newCard = $("[card-index=\"#{newIndex}\"]",@containerElement)
			oldCard = []
			return unless newCard.size() > 0
			return unless newIndex != @currentIndex

			$(newCard).each (index, element) =>
				do(element)->
					$(element).trigger('appear')
					$(element).show()
					$(element).trigger('appeared')

			$('[card-index]',@containerElement).each (index, element) =>
				i = $(element).attr('card-index')
				if i != newIndex+''
					if $(element).is(':visible')
						oldCard.push $(element)
						$(element).trigger('disappear') 
						$(element).hide()
						$(element).trigger('disappeared')

			@currentIndex=newIndex-0 # Number conversion
			@updateButtons()

			$(@containerElement).trigger('card-changed', oldCard, newCard)

		updateButtons: () ->
			if $("[card-index=\"#{@currentIndex+1}\"]",@containerElement).size() > 0
				$("[card-change=\"next\"]",@containerElement).each (index, element) => 
					#$(element).removeClass('disabled')
					$(element).show()
			else 
				$("[card-change=\"next\"]",@containerElement).each (index, element) => 
					#$(element).addClass('disabled')
					$(element).hide()

			if $("[card-index=\"#{@currentIndex-1}\"]",@containerElement).size() > 0
				$("[card-change=\"previous\"]",@containerElement).each (index, element) => 
					#$(element).removeClass('disabled')
					$(element).show()
			else 
				$("[card-change=\"previous\"]",@containerElement).each (index, element) => 
					#$(element).addClass('disabled')
					$(element).hide()


	# A really lightweight plugin wrapper around the constructor,
	# preventing against multiple instantiations
	$.fn[pluginName] = (options) ->
		@each ->
			if !$.data(this, "plugin_#{pluginName}")
				$.data(@, "plugin_#{pluginName}", new CardContainer(@, options))
			if typeof options == 'string'
				$.data(this, "plugin_#{pluginName}")[options]()
)(jQuery, window)

$ ->
	$('.card-container').cardcontainer()
###
$ ->
	$('.card-container').each ->
		new CardContainer($(this))
###