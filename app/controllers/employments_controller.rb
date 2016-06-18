class EmploymentsController < ApplicationController
  before_action :set_employment, only: [:show, :edit, :update, :destroy]

  # GET /employments
  # GET /employments.json
  def index
    @currentYear = Time.new.year
    @lastYear = @currentYear - 1
    @response = HTTParty.post('http://api.bls.gov/publicAPI/v2/timeseries/data/',
    {
      headers: { 'Content-Type' => 'application/json', 'Accept' => 'application/json'},
      body:
          {'seriesid' => ['LAUMT114790000000003', 'LAUMT257165000000003', 'LAUMT481910000000003', 'LAUMT482642000000003', 'LAUMT043806000000003', 'LAUMT131206000000003', 'LAUMT363562000000003', 'LAUMT171698000000003'],
            'startyear' => "#{@lastYear}",
            'endyear' => "#{@currentYear}",
            'registrationKey' => ENV['registrationKey']
          }.to_json,
          :content_type => 'application/json'

    })
    @result = @response.body
    @result = JSON.parse(@result)

    @latestMonth = @result["Results"]["series"][0]["data"][0]["periodName"]
    @latestYear = @result["Results"]["series"][0]["data"][0]["year"]
    @graph = ["labels"=>[], "latestMonthResult"=>[], "oneYearPriorResult"=>[]]
    @graph[0]["labels"] << "#{@latestMonth} #{@latestYear}"
    @graph[0]["labels"] << "#{@latestMonth} #{@latestYear.to_i - 1}"
    @result["Results"]["series"].each do |series|
      @graph[0]["latestMonthResult"] << series["data"][0]["value"].to_f
      @graph[0]["oneYearPriorResult"] << series["data"][12]["value"].to_f
    end

    respond_to do |format|
      format.json { render :json => @graph }
      format.html { render "index.html.erb" }
    end

  end

  def national_data
    @currentYear = Time.new.year
    @lastYear = @currentYear - 1
    # @nationalData = HTTParty.post('http://api.bls.gov/publicAPI/v2/timeseries/data/',
    # {
    #   headers: { 'Content-Type' => 'application/json', 'Accept' => 'application/json'},
    #   body:
    #       {'seriesid' => ['LNS14000000', 'CES0000000001', 'CES0500000003'],
    #         'startyear' => "#{@lastYear}",
    #         'endyear' => "#{@currentYear}",
    #         'registrationKey' => ENV['registrationKey']
    #       }.to_json,
    #       :content_type => 'application/json'
    #
    # })

    # @nationalResult = @nationalData.body
    # @nationalResult = JSON.parse(@nationalResult)

    @data = {"series":[{"seriesID":"CES0000000001","data":[{"year":"2016","period":"M05","periodName":"May","value":"143894","footnotes":[{"code":"P","text":"preliminary"}]},{"year":"2016","period":"M04","periodName":"April","value":"143856","footnotes":[{"code":"P","text":"preliminary"}]},{"year":"2016","period":"M03","periodName":"March","value":"143733","footnotes":[{}]},{"year":"2016","period":"M02","periodName":"February","value":"143547","footnotes":[{}]},{"year":"2016","period":"M01","periodName":"January","value":"143314","footnotes":[{}]},{"year":"2015","period":"M12","periodName":"December","value":"143146","footnotes":[{}]},{"year":"2015","period":"M11","periodName":"November","value":"142875","footnotes":[{}]},{"year":"2015","period":"M10","periodName":"October","value":"142595","footnotes":[{}]},{"year":"2015","period":"M09","periodName":"September","value":"142300","footnotes":[{}]},{"year":"2015","period":"M08","periodName":"August","value":"142151","footnotes":[{}]},{"year":"2015","period":"M07","periodName":"July","value":"142001","footnotes":[{}]},{"year":"2015","period":"M06","periodName":"June","value":"141724","footnotes":[{}]},{"year":"2015","period":"M05","periodName":"May","value":"141496","footnotes":[{}]},{"year":"2015","period":"M04","periodName":"April","value":"141223","footnotes":[{}]},{"year":"2015","period":"M03","periodName":"March","value":"140972","footnotes":[{}]},{"year":"2015","period":"M02","periodName":"February","value":"140888","footnotes":[{}]},{"year":"2015","period":"M01","periodName":"January","value":"140623","footnotes":[{}]}]},{"seriesID":"LNS14000000","data":[{"year":"2016","period":"M05","periodName":"May","value":"4.7","footnotes":[{}]},{"year":"2016","period":"M04","periodName":"April","value":"5.0","footnotes":[{}]},{"year":"2016","period":"M03","periodName":"March","value":"5.0","footnotes":[{}]},{"year":"2016","period":"M02","periodName":"February","value":"4.9","footnotes":[{}]},{"year":"2016","period":"M01","periodName":"January","value":"4.9","footnotes":[{}]},{"year":"2015","period":"M12","periodName":"December","value":"5.0","footnotes":[{}]},{"year":"2015","period":"M11","periodName":"November","value":"5.0","footnotes":[{}]},{"year":"2015","period":"M10","periodName":"October","value":"5.0","footnotes":[{}]},{"year":"2015","period":"M09","periodName":"September","value":"5.1","footnotes":[{}]},{"year":"2015","period":"M08","periodName":"August","value":"5.1","footnotes":[{}]},{"year":"2015","period":"M07","periodName":"July","value":"5.3","footnotes":[{}]},{"year":"2015","period":"M06","periodName":"June","value":"5.3","footnotes":[{}]},{"year":"2015","period":"M05","periodName":"May","value":"5.5","footnotes":[{}]},{"year":"2015","period":"M04","periodName":"April","value":"5.4","footnotes":[{}]},{"year":"2015","period":"M03","periodName":"March","value":"5.5","footnotes":[{}]},{"year":"2015","period":"M02","periodName":"February","value":"5.5","footnotes":[{}]},{"year":"2015","period":"M01","periodName":"January","value":"5.7","footnotes":[{}]}]},{"seriesID":"CES0500000003","data":[{"year":"2016","period":"M05","periodName":"May","value":"25.59","footnotes":[{"code":"P","text":"preliminary"}]},{"year":"2016","period":"M04","periodName":"April","value":"25.54","footnotes":[{"code":"P","text":"preliminary"}]},{"year":"2016","period":"M03","periodName":"March","value":"25.45","footnotes":[{}]},{"year":"2016","period":"M02","periodName":"February","value":"25.39","footnotes":[{}]},{"year":"2016","period":"M01","periodName":"January","value":"25.38","footnotes":[{}]},{"year":"2015","period":"M12","periodName":"December","value":"25.26","footnotes":[{}]},{"year":"2015","period":"M11","periodName":"November","value":"25.27","footnotes":[{}]},{"year":"2015","period":"M10","periodName":"October","value":"25.21","footnotes":[{}]},{"year":"2015","period":"M09","periodName":"September","value":"25.14","footnotes":[{}]},{"year":"2015","period":"M08","periodName":"August","value":"25.12","footnotes":[{}]},{"year":"2015","period":"M07","periodName":"July","value":"25.03","footnotes":[{}]},{"year":"2015","period":"M06","periodName":"June","value":"24.96","footnotes":[{}]},{"year":"2015","period":"M05","periodName":"May","value":"24.97","footnotes":[{}]},{"year":"2015","period":"M04","periodName":"April","value":"24.91","footnotes":[{}]},{"year":"2015","period":"M03","periodName":"March","value":"24.87","footnotes":[{}]},{"year":"2015","period":"M02","periodName":"February","value":"24.80","footnotes":[{}]},{"year":"2015","period":"M01","periodName":"January","value":"24.76","footnotes":[{}]}]}]}
    @data = @data.to_json
    @data = JSON.parse(@data)

    @nationalUnemployment = @data['series'].select {|x| x["seriesID"] === 'LNS14000000'  }
    @nationalUnemployment = @nationalUnemployment[0]['data']
    @nationalDataGraph = {'unemployment' => ["labels"=>[], "label"=>[], "value"=>[]]}
    @nationalUnemployment.each do |month|
      @nationalDataGraph['unemployment'][0]["labels"].unshift("#{month["periodName"]} #{month["year"]}" )
      @nationalDataGraph['unemployment'][0]["value"].unshift(month["value"].to_f)
    end

    @nationalEmployment = @data['series'].select {|x| x["seriesID"] === 'CES0000000001'  }
    @nationalEmployment = @nationalEmployment[0]['data'][0]
    # @month = @nationalEmployment
    # @month = @month.slice(1..2).to_f


    respond_to do |format|
      format.json { render :json => @nationalEmployment }
      format.html { render "national-data.html.erb" }
    end
  end

end
