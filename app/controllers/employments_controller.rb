class EmploymentsController < ApplicationController
  before_action :set_employment, only: [:show, :edit, :update, :destroy]

  # GET /employments
  # GET /employments.json
  def index
    currentYear = Time.new.year
    lastYear = currentYear - 1
    @response = HTTParty.post('http://api.bls.gov/publicAPI/v2/timeseries/data/',
    {
      headers: { 'Content-Type' => 'application/json', 'Accept' => 'application/json'},
      body:
          {'seriesid' => ['LAUMT114790000000003', 'LAUMT257165000000003', 'LAUMT481910000000003', 'LAUMT482642000000003', 'LAUMT043806000000003', 'LAUMT131206000000003', 'LAUMT363562000000003', 'LAUMT171698000000003'],
            'startyear' => "#{lastYear}",
            'endyear' => "#{currentYear}",
            'registrationKey' => ENV['registrationKey']
          }.to_json,
          :content_type => 'application/json'

    })
    @result = @response.body
    @result = JSON.parse(@result)

    # @result = {"Results"=>{"series":[{"seriesID":"LAUMT114790000000003","data":[{"year":"2016","period":"M03","periodName":"March","value":"4.1","footnotes":[{"code":"P","text":"Preliminary."}]},{"year":"2016","period":"M02","periodName":"February","value":"4.1","footnotes":[{}]},{"year":"2016","period":"M01","periodName":"January","value":"4.2","footnotes":[{}]},{"year":"2015","period":"M12","periodName":"December","value":"3.9","footnotes":[{"code":"R","text":"Data were subject to revision on April 15, 2016."}]},{"year":"2015","period":"M11","periodName":"November","value":"4.1","footnotes":[{"code":"R","text":"Data were subject to revision on April 15, 2016."}]},{"year":"2015","period":"M10","periodName":"October","value":"4.2","footnotes":[{"code":"R","text":"Data were subject to revision on April 15, 2016."}]},{"year":"2015","period":"M09","periodName":"September","value":"4.3","footnotes":[{"code":"R","text":"Data were subject to revision on April 15, 2016."}]},{"year":"2015","period":"M08","periodName":"August","value":"4.4","footnotes":[{"code":"R","text":"Data were subject to revision on April 15, 2016."}]},{"year":"2015","period":"M07","periodName":"July","value":"4.6","footnotes":[{"code":"R","text":"Data were subject to revision on April 15, 2016."}]},{"year":"2015","period":"M06","periodName":"June","value":"4.7","footnotes":[{"code":"R","text":"Data were subject to revision on April 15, 2016."}]},{"year":"2015","period":"M05","periodName":"May","value":"4.5","footnotes":[{"code":"R","text":"Data were subject to revision on April 15, 2016."}]},{"year":"2015","period":"M04","periodName":"April","value":"4.2","footnotes":[{"code":"R","text":"Data were subject to revision on April 15, 2016."}]},{"year":"2015","period":"M03","periodName":"March","value":"4.6","footnotes":[{"code":"R","text":"Data were subject to revision on April 15, 2016."}]},{"year":"2015","period":"M02","periodName":"February","value":"4.9","footnotes":[{"code":"R","text":"Data were subject to revision on April 15, 2016."}]},{"year":"2015","period":"M01","periodName":"January","value":"5.0","footnotes":[{"code":"R","text":"Data were subject to revision on April 15, 2016."}]}]},{"seriesID":"LAUMT481910000000003","data":[{"year":"2016","period":"M03","periodName":"March","value":"3.8","footnotes":[{"code":"P","text":"Preliminary."}]},{"year":"2016","period":"M02","periodName":"February","value":"3.7","footnotes":[{}]},{"year":"2016","period":"M01","periodName":"January","value":"3.8","footnotes":[{}]},{"year":"2015","period":"M12","periodName":"December","value":"3.6","footnotes":[{"code":"R","text":"Data were subject to revision on April 15, 2016."}]},{"year":"2015","period":"M11","periodName":"November","value":"3.9","footnotes":[{"code":"R","text":"Data were subject to revision on April 15, 2016."}]},{"year":"2015","period":"M10","periodName":"October","value":"4.0","footnotes":[{"code":"R","text":"Data were subject to revision on April 15, 2016."}]},{"year":"2015","period":"M09","periodName":"September","value":"4.0","footnotes":[{"code":"R","text":"Data were subject to revision on April 15, 2016."}]},{"year":"2015","period":"M08","periodName":"August","value":"4.1","footnotes":[{"code":"R","text":"Data were subject to revision on April 15, 2016."}]},{"year":"2015","period":"M07","periodName":"July","value":"4.3","footnotes":[{"code":"R","text":"Data were subject to revision on April 15, 2016."}]},{"year":"2015","period":"M06","periodName":"June","value":"4.3","footnotes":[{"code":"R","text":"Data were subject to revision on April 15, 2016."}]},{"year":"2015","period":"M05","periodName":"May","value":"4.0","footnotes":[{"code":"R","text":"Data were subject to revision on April 15, 2016."}]},{"year":"2015","period":"M04","periodName":"April","value":"3.8","footnotes":[{"code":"R","text":"Data were subject to revision on April 15, 2016."}]},{"year":"2015","period":"M03","periodName":"March","value":"4.1","footnotes":[{"code":"R","text":"Data were subject to revision on April 15, 2016."}]},{"year":"2015","period":"M02","periodName":"February","value":"4.2","footnotes":[{"code":"R","text":"Data were subject to revision on April 15, 2016."}]},{"year":"2015","period":"M01","periodName":"January","value":"4.5","footnotes":[{"code":"R","text":"Data were subject to revision on April 15, 2016."}]}]},{"seriesID":"LAUMT257165000000003","data":[{"year":"2016","period":"M03","periodName":"March","value":"4.0","footnotes":[{"code":"P","text":"Preliminary."}]},{"year":"2016","period":"M02","periodName":"February","value":"4.0","footnotes":[{}]},{"year":"2016","period":"M01","periodName":"January","value":"4.3","footnotes":[{}]},{"year":"2015","period":"M12","periodName":"December","value":"4.0","footnotes":[{"code":"R","text":"Data were subject to revision on April 15, 2016."}]},{"year":"2015","period":"M11","periodName":"November","value":"4.1","footnotes":[{"code":"R","text":"Data were subject to revision on April 15, 2016."}]},{"year":"2015","period":"M10","periodName":"October","value":"4.1","footnotes":[{"code":"R","text":"Data were subject to revision on April 15, 2016."}]},{"year":"2015","period":"M09","periodName":"September","value":"4.5","footnotes":[{"code":"R","text":"Data were subject to revision on April 15, 2016."}]},{"year":"2015","period":"M08","periodName":"August","value":"4.3","footnotes":[{"code":"R","text":"Data were subject to revision on April 15, 2016."}]},{"year":"2015","period":"M07","periodName":"July","value":"4.7","footnotes":[{"code":"R","text":"Data were subject to revision on April 15, 2016."}]},{"year":"2015","period":"M06","periodName":"June","value":"4.8","footnotes":[{"code":"R","text":"Data were subject to revision on April 15, 2016."}]},{"year":"2015","period":"M05","periodName":"May","value":"4.5","footnotes":[{"code":"R","text":"Data were subject to revision on April 15, 2016."}]},{"year":"2015","period":"M04","periodName":"April","value":"4.2","footnotes":[{"code":"R","text":"Data were subject to revision on April 15, 2016."}]},{"year":"2015","period":"M03","periodName":"March","value":"4.6","footnotes":[{"code":"R","text":"Data were subject to revision on April 15, 2016."}]},{"year":"2015","period":"M02","periodName":"February","value":"4.9","footnotes":[{"code":"R","text":"Data were subject to revision on April 15, 2016."}]},{"year":"2015","period":"M01","periodName":"January","value":"5.1","footnotes":[{"code":"R","text":"Data were subject to revision on April 15, 2016."}]}]}]}}
    # @result = @result.to_json
    # @result = JSON.parse(@result)

    @latestMonth = @result["Results"]["series"][0]["data"][0]["periodName"]
    @latestYear = @result["Results"]["series"][0]["data"][0]["year"]
    # @latestMonthResult = @result["Results"]["series"][0]["data"][0]["value"]
    # @oneYearPriorResult = @result["Results"]["series"][0]["data"][12]["value"]
    @graph = ["labels"=>[], "latestMonthResult"=>[], "oneYearPriorResult"=>[]]
    @graph[0]["labels"] << "#{@latestMonth} #{@latestYear}"
    @graph[0]["labels"] << "#{@latestMonth} #{@latestYear.to_i - 1}"
    @result["Results"]["series"].each do |series|
      @graph[0]["latestMonthResult"] << series["data"][0]["value"].to_f
      @graph[0]["oneYearPriorResult"] << series["data"][12]["value"].to_f
    end

    # @graph[0]["latestMonthResult"] = @latestMonthResult
    # @graph[0]["oneYearPriorResult"] = @oneYearPriorResult
    # @graph[0]['latestYear'] = @latestYear

    # ["data"].find_index {|test| test["periodName"] == "March"}
    respond_to do |format|
      format.json { render :json => @graph }
      format.html { render "index.html.erb" }
    end

  end

    # GET /employments/1
    # GET /employments/1.json
    def show
    end

    # GET /employments/new
    def new
      @employment = Employment.new
    end

    # GET /employments/1/edit
    def edit
    end

    # POST /employments
    # POST /employments.json
    def create
      @employment = Employment.new(employment_params)

      respond_to do |format|
        if @employment.save
          format.html { redirect_to @employment, notice: 'Employment was successfully created.' }
          format.json { render :show, status: :created, location: @employment }
        else
          format.html { render :new }
          format.json { render json: @employment.errors, status: :unprocessable_entity }
        end
      end
    end

    # PATCH/PUT /employments/1
    # PATCH/PUT /employments/1.json
    def update
      respond_to do |format|
        if @employment.update(employment_params)
          format.html { redirect_to @employment, notice: 'Employment was successfully updated.' }
          format.json { render :show, status: :ok, location: @employment }
        else
          format.html { render :edit }
          format.json { render json: @employment.errors, status: :unprocessable_entity }
        end
      end
    end

    # DELETE /employments/1
    # DELETE /employments/1.json
    def destroy
      @employment.destroy
      respond_to do |format|
        format.html { redirect_to employments_url, notice: 'Employment was successfully destroyed.' }
        format.json { head :no_content }
      end
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_employment
      @employment = Employment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def employment_params
      params.require(:employment).permit(:value)
    end
end
