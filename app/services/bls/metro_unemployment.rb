module Bls
  class MetroUnemployment

    def self.call
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

      return @result
    end

  end
end
