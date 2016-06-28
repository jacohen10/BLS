class NationalDataController < ApplicationController
  before_action :set_employment, only: [:show, :edit, :update, :destroy]

  def index
    # @metroUnemployment = Bls::MetroUnemployment.call
    # @graph = metro_unemployment(@metroUnemployment)
    @metroUnemploymentCombo = Bls::MetroUnemploymentCombo.call
    @comboCities = metro_unemployment_combos(@metroUnemploymentCombo)

    respond_to do |format|
      format.json { render :json => @metroUnemploymentCombo }
      format.html { render "index.html.erb" }
    end

  end

  def national_data
    @data = Bls::NationalData.call

    @graphData = {}
    @graphData[:national_unemployment] = (national_unemployment(@data))
    @graphData[:national_employment] = (national_employment_1_month(@data))

    respond_to do |format|
      format.json { render :json => @graphData }
      format.html { render "national-data.html.erb" }
    end
  end

  def national_employment
    render 'employment.erb'
  end

  private

  def metro_unemployment(data)
    @latestMonth = data["Results"]["series"][0]["data"][0]["periodName"]
    @latestYear = data["Results"]["series"][0]["data"][0]["year"]
    @graph = ["labels"=>[], "latestMonthResult"=>[], "oneYearPriorResult"=>[]]
    @graph[0]["labels"] << "#{@latestMonth} #{@latestYear}"
    @graph[0]["labels"] << "#{@latestMonth} #{@latestYear.to_i - 1}"
    data["Results"]["series"].each do |series|
      @graph[0]["latestMonthResult"] << series["data"][0]["value"].to_f
      @graph[0]["oneYearPriorResult"] << series["data"][12]["value"].to_f
    end
    return @graph
  end

  def metro_unemployment_combos(data)

  end

  def national_unemployment(data)
    @nationalUnemployment = data['series'].select {|x| x["seriesID"] === 'LNS14000000'  }
    @nationalUnemployment = @nationalUnemployment[0]['data']
    graph = {"labels"=>[], "value"=>[]}
    @nationalUnemployment.each do |month|
      graph["labels"].unshift("#{month["periodName"]} #{month["year"]}" )
      graph["value"].unshift(month["value"].to_f)
    end
    return graph
  end

  def national_employment_1_month(data)
    @nationalEmployment = @data['series'].select {|x| x["seriesID"] === 'CES0000000001'  }
    @graph = {"labels"=>[], "value"=>[]}
    @nationalEmployment[0]['data'].each_with_index do |month, index|
      if index == @nationalEmployment[0]['data'].index(@nationalEmployment[0]['data'].last)
        break
      end
      oneMonthChange = month['value'].to_f - @nationalEmployment[0]['data'][index + 1]['value'].to_f
      @graph['value'].unshift(oneMonthChange)
      @graph['labels'].unshift("#{month["periodName"]} #{month["year"]}" )
    end
    return @graph
  end

end
