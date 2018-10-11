module ApplicationHelper

  def full_title(page_title = '')
    base_title = "Tea Tree"
    if page_title.empty?
      base_title
    else
      "#{page_title} | #{base_title}"
    end
  end

  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  def remove_unwanted_words string
    bad_words = ["less than", "about"]

    bad_words.each do |bad|
      string.gsub!(bad + " ", '')
    end

    return string
  end

  def currency
    [
      ['USD'],
      ['AUD'],
      ['CAD'],
      ['CHF'],
      ['DKK'],
      ['EUR'],
      ['GBP'],
      ['JPY'],
      ['MXN'],
      ['NOK'],
      ['SEK'],
      ['SGD']
    ]
  end

  def country
    [
      ['US | United States'],
      ['AT | Austria'],
      ['AU | Australia'],
      ['BE | Belgium'],
      ['CA | Canada'],
      ['DE | Germany'],
      ['DK | Denmark'],
      ['ES | Spain'],
      ['FI | Finland'],
      ['FR | France'],
      ['GB | United Kingdom'],
      ['IE | Ireland'],
      ['IT | Italy'],
      ['JP | Japan'],
      ['LU | Luxembourg'],
      ['MX | Mexico'],
      ['NL | Netherlands'],
      ['NO | Norway'],
      ['SE | Sweden']
    ]
  end

end
