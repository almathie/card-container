$ ->
	$('.card-container').each ->
		new CardContainer($(this))

class CardContainer
	constructor: (@containerElement) ->
		@changeCard 0

		#$('[card-change]',@containerElement).on 'click', (event)=>
		$(@containerElement).on 'click.card-container', "[card-change]", (event)=>
			switch $(event.target).attr('card-change')
				when "next" then @changeCard @currentIndex+1
				when "previous" then @changeCard @currentIndex-1
				else

	changeCard: (newIndex) ->
		#newCard = $('[card-index=#{@newIndex}]',@containerElement)
		return unless $("[card-index=\"#{newIndex}\"]",@containerElement).size() > 0

		$('[card-index]',@containerElement).each (index, element) =>
			i = $(element).attr('card-index')
			if i is newIndex+''
				#$(element).css('visibility', 'visible')
				$(element).show()
			else 
				#$(element).css('visibility', 'hidden')
				$(element).hide()

		if $("[card-index=\"#{newIndex+1}\"]",@containerElement).size() > 0
			$("[card-change=\"next\"]",@containerElement).each (index, element) => 
				$(element).removeClass('disabled')
		else 
			$("[card-change=\"next\"]",@containerElement).each (index, element) => 
				$(element).addClass('disabled')

		if $("[card-index=\"#{newIndex-1}\"]",@containerElement).size() > 0
			$("[card-change=\"previous\"]",@containerElement).each (index, element) => 
				$(element).removeClass('disabled')
		else 
			$("[card-change=\"previous\"]",@containerElement).each (index, element) => 
				$(element).addClass('disabled')

		@currentIndex=newIndex


