class TripsController < ApplicationController
  before_filter :authenticate_user!
  
  # GET /trips
  # GET /trips.json
  def index
    @user = User.find_by_id(params[:user_id])
    if !@user.nil?
      @trips = Trip.public_trip.page(params[:all_page]).per(10)
      @my_trips = @user.trips.page(params[:my_page]).per(10)
    else
      flash[:notice] = "User not found"
      return redirect_back_or_default(home_index_path)
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @trips }
      format.js
    end
  end

  # GET /trips/1
  # GET /trips/1.json
  def show
    @user = User.find_by_id(params[:user_id])
    if !@user.nil?
      @trip = @user.trips.find_by_id(params[:id])
      if !@trip.nil?
        @globalArray = read_all_data_with_distance(@trip.datalog.path,200)
        @globalArray.to_json
      else
        flash[:notice] = "Trip not found"
        return redirect_back_or_default(user_trips_path(@user))
      end

    else
      flash[:notice] = "User not found"
      return redirect_back_or_default(home_index_path)
    end

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @trip }
    end
  end

  def ajax_read_all_data
    @user = User.find_by_id(params[:user_id])
    @trip = @user.trips.find(params[:trip_id])

    @globalArray = read_all_data_with_distance(@trip.datalog.path,(params[:distance]).to_i)
    puts "----"
    puts @globalArray
    @globalArray.to_json
    
    respond_to do |format|
      format.js
      format.json { render json: @trip }
    end
  end
  # GET /trips/new
  # GET /trips/new.json
  def new
    @user = User.find_by_id(params[:user_id])
    if !@user.nil?
      @trip = @user.trips.new
    else
      flash[:notice] = "User not found"
      return redirect_back_or_default(home_index_path)
    end

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @trip }
    end
  end

  # GET /trips/1/edit
  def edit
    @user = User.find_by_id(params[:user_id])
    if !@user.nil?
      @trip = @user.trips.find_by_id(params[:id])
    else
      flash[:notice] = "User not found"
      return redirect_back_or_default(home_index_path)
    end
  end

  # POST /trips
  # POST /trips.json
  def create
    @user = User.find_by_id(params[:user_id])
    if !@user.nil?
      @trip = @user.trips.new(params[:trip])
    else
      flash[:notice] = "User not found"
      return redirect_back_or_default(home_index_path)
    end

    respond_to do |format|
      if @trip.save
        format.html { redirect_to user_trip_path(@user, @trip), notice: 'Trip was successfully created.' }
        format.json { render json: @trip, status: :created, location: @trip }
      else
        format.html { render action: "new" }
        format.json { render json: @trip.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /trips/1
  # PUT /trips/1.json
  def update
    @user = User.find_by_id(params[:user_id])
    if !@user.nil?
      @trip = @user.trips.find_by_id(params[:id])
    else
      flash[:notice] = "User not found"
      return redirect_back_or_default(home_index_path)
    end

    respond_to do |format|
      if @trip.update_attributes(params[:trip])
        format.html { redirect_to user_trip_path(@user, @trip), notice: 'Trip was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @trip.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /trips/1
  # DELETE /trips/1.json
  def destroy
    @user = User.find_by_id(params[:user_id])
    if !@user.nil?
      @trip = @user.trips.find_by_id(params[:id])
      @trip.destroy
    else
      flash[:notice] = "User not found"
      return redirect_back_or_default(home_index_path)
    end

    respond_to do |format|
      format.html { redirect_to user_trips_path(@user) }
      format.json { head :no_content }
    end
  end

  def read_all_data(filepath)
    File.open(filepath, 'r') do |f1|
        globalArray = []
        counter = 0
        lineNum = 0
        lineBefore = ""
        while line = f1.gets
            line.strip!
            element = line.split(',')
            if (element[0] == "$GPRMC")
                if counter == 0
                    arrayOfOutput = []
                end
                obj = Hash.new

                #membaca data GPS
                date = element[9]
                if !date.nil?
                  if date.length >= 6
                    date_gps = date[0, 2] + "-" + date[2, 2] + "-" + date[4, 2]
                    obj['date'] = date_gps
                  else
                    obj['date'] = ''
                  end
                else
                    obj['date'] = ''
                end

                arrTime = element[1].split(".")
                time = arrTime[0]
                if !time.nil?
                  if time.length >= 6
                    time = time[0, 2] + ":" + time[2, 2] + ":" + time[4, 2]
                    obj['time'] = time
                  else
                    obj['time'] = ''
                  end
                else
                    obj['time'] = ''
                end

                longitude = element[5].to_f
                latitude = element[3].to_f
                nssign = element[4]
                ewsign = element[6]
                longitude = (ewsign == "W" ? -1 : 1) * (( (longitude / 100)) + (( ( longitude % 100)) + (longitude - longitude)) / 60)
                latitude = (ewsign == "S" ? -1 : 1) * (( (latitude / 100)) + (( ( latitude % 100)) + (latitude - latitude)) / 60)
                if (longitude == 0 && latitude == 0)
                    next
                end
                obj['lng'] = longitude
                obj['lat'] = latitude

                longitude = element[5].to_f
                latitude = element[3].to_f
                #nssign = element[4]
                #ewsign = element[6]
                lat_d = (latitude / 100).floor
                lng_d = (longitude / 100).floor
                lat_m = (latitude).floor % 100
                lng_m = (longitude).floor % 100
                lat_s = ((latitude - (latitude).floor) * 10000).floor
                lng_s = ((longitude - (longitude).floor) * 10000).floor
                obj['latlng'] = "Lat : " + lat_d.to_s + "&deg; " + lat_m.to_s + "' " + lat_s.to_s + "\", Lng : " + lng_d.to_s + "&deg; " + lng_m.to_s + "' " + lng_s.to_s + "\" "
                obj['latdms'] = lat_d.to_s + "&deg; " + lat_m.to_s + "' " + lat_s.to_s + "\""
                obj['lngdms'] = lng_d.to_s + "&deg; " + lng_m.to_s + "' " + lng_s.to_s + "\""
                arrayOfOutput << obj
                counter = counter + 1
            elsif (element[0] == "$ECU")
                if (element.count > 4)
                    for el in element do
                        if (el.strip! == "")
                            el = 0
                        end
                    end

                    # membaca data mesin
                    obj = []

                    # sidestand switch
                    obj[29] = element[1].to_f
                    # kill switch
                    obj[30] = element[4].to_f
                    # clutch switch
                    obj[31] = element[5].to_f
                    # start switch
                    obj[32] = element[7].to_f
                    # secondary air valve
                    obj[20] = element[8].to_f
                    # actuation of starter relay
                    obj[21] = element[9].to_f
                    # lambda sensor heating
                    obj[22] = element[10].to_f
                    # electric fuel pump
                    obj[23] = element[11].to_f
                    # Electric Fan Pump
                    obj[24] = element[12].to_f
                    # Engine Safety Cut Out (of BMSK)
                    obj[25] = element[13].to_f
                    # Starter Function (of BMSK)
                    obj[26] = element[14].to_f
                    # Starter Safety Cut Out (of BMSK)
                    obj[27] = element[15].to_f
                    # Engine Light (MIL)
                    obj[28] = element[16].to_f
                    # Injection Time
                    obj[14] = element[17].to_f
                    # Lambda Control Factor
                    obj[15] = element[18].to_f
                    # Vehicle Speed
                    obj[1] = element[19].to_f
                    # Engine RPM
                    obj[2] = (element[20].to_f).round
                    # Intake Air Temperature
                    obj[4] = element[21].to_f
                    # Engine Temperature
                    obj[3] = element[22].to_f
                    # Ignition Angle
                    obj[16] = element[23].to_f
                    # Throttle Position
                    obj[5] = element[24].to_f
                    # Engine Load
                    obj[6] = element[25].to_f
                    # Battery Voltage
                    obj[7] = element[26].to_f
                    # Knock Sensor 1
                    obj[8] = element[27].to_f
                    # Knock Sensor 2
                    obj[9] = element[28].to_f
                    # Ignition Dwell Time
                    obj[17] = element[29].to_f
                    # Odometer
                    obj[10] = element[30].to_f
                    # Position of Idle Actuator
                    obj[18] = element[33].to_f
                    # Position of Idle Actuator at Full Load
                    obj[19] = element[34].to_f
                    # Ambient Air Pressure
                    obj[11] = element[36].to_f
                    # Lambda Sensor Voltage
                    obj[12] = element[37].to_f
                    # Gear
                    obj[13] = element[38].to_f
                    obj[33] = element[39]

                    #File_Model::currentName = element[39]
                    arrayOfOutput[counter - 1]['additional'] = obj
                    strWrite = -1
                else
                    arrayOfOutput[counter - 1]['additional'] = []
                end
            elsif (line == "IGNITION OFF" && lineBefore != "IGNITION OFF")
                if (!arrayOfOutput.nil?)
                    #arrayOfOutput[counter - 1]['additional'] = get_off_value()
                    # copy array
                    arrCopy = []
                    for el in arrayOfOutput do
                        arrCopy << el
                    end
                    globalArray << arrCopy
                end
                counter = 0
            end
            lineNum = lineNum + 1
            lineBefore = line
        end
        return globalArray
    end
  end

  def read_all_data_with_distance(fileName,distance)
    #if(!(distance)){
    #    die("Distance not yet set.")
    #}
    puts "--------"
    puts fileName
    puts distance
    data = read_all_data(fileName)

    #filtering data
    globalArray = []
    for el1 in data
        for el2 in el1
            if(el2['additional']!=[] || el2.has_key?('additional'))
                globalArray << el2
            end
        end
    end

    newGlobalArray = []
#    for trip in globalArray
        trip = globalArray
        newTripArray = []
        latTemp = 0
        longTemp = 0
        distanceRemain = distance

        #draw first marker
        marker = {}
        marker['lat'] = trip[0]['lat']
        marker['lng'] = trip[0]['lng']
        marker['latdms'] = trip[0]['latdms']
        marker['lngdms'] = trip[0]['lngdms']
        marker['date'] = trip[0]['date']
        marker['time'] = trip[0]['time']
        marker['latlng'] = trip[0]['latlng']
        #sidestand switch
        if(trip[0]['additional']!=nil || trip[0].has_key?('additional'))
            marker['additional'] = []
            marker['additional'][29] = trip[0]['additional'][29]
            #kill switch
            marker['additional'][30] = trip[0]["additional"][30]
            #clutch switch
            marker['additional'][31] = trip[0]["additional"][31]
            #start switch
            marker['additional'][32] = trip[0]["additional"][32]
            #secondary air valve
            marker['additional'][20] = trip[0]["additional"][20]
            #actuation of starter relay
            marker['additional'][21] = trip[0]["additional"][21]
            #lambda sensor heating
            marker['additional'][22] = trip[0]["additional"][22]
            #electric fuel pump
            marker['additional'][23] = trip[0]["additional"][23]
            #Electric Fan Pump
            marker['additional'][24] = trip[0]["additional"][24]
            #Engine Safety Cut Out (of BMSK)
            marker['additional'][25] = trip[0]["additional"][25]
            #Starter Function (of BMSK)
            marker['additional'][26] = trip[0]["additional"][26]
            #Starter Safety Cut Out (of BMSK)
            marker['additional'][27] = trip[0]["additional"][27]
            #Engine Light (MIL)
            marker['additional'][28] = trip[0]["additional"][28]
            #Injection Time
            marker['additional'][14] = trip[0]["additional"][14]
            #Lambda Control Factor
            marker['additional'][15] = trip[0]["additional"][15]
            #Vehicle Speed
            marker['additional'][1] = trip[0]["additional"][1]
            #Engine RPM
            marker['additional'][2] = trip[0]["additional"][2]
            #Intake Air Temperature
            marker['additional'][4] = trip[0]["additional"][4]
            #Engine Temperature
            marker['additional'][3] = trip[0]["additional"][3]
            #Throttle Position
            marker['additional'][5] = trip[0]["additional"][5]
            #Engine Load
            marker['additional'][6] = trip[0]["additional"][6]
            #Battery Voltage
            marker['additional'][7] = trip[0]["additional"][7]
            #Knock Sensor 1
            marker['additional'][8] = trip[0]["additional"][8]
            #Knock Sensor 2
            marker['additional'][9] = trip[0]["additional"][9]
            #Ignition Time
            marker['additional'][16] = trip[0]["additional"][16]
            #Ignition Dwell Time
            marker['additional'][17] = trip[0]["additional"][17]
            #Odometer
            marker['additional'][10] = trip[0]["additional"][10]
            #Position of Idle Actuator
            marker['additional'][18] = trip[0]["additional"][18]
            #Position of Idle Actuator at Full Load
            marker['additional'][19] = trip[0]["additional"][19]
            #Ambient Air Pressure
            marker['additional'][11] = trip[0]["additional"][11]
            #Lambda Sensor Voltage
            marker['additional'][12] = trip[0]["additional"][12]
            #Gear
            marker['additional'][13] = trip[0]["additional"][13]
            marker['additional'][33] = trip[0]["additional"][33]
        end
        newTripArray << marker

        for i in 0..(trip.count - 2)
        #for (i = 0 i < count(trip) - 2 i++) {
            location = trip[i]
            currentDistance = calculateDistance(trip[i]['lat'], trip[i]['lng'], trip[i + 1]['lat'], trip[i + 1]['lng'])
            if (currentDistance < distanceRemain)
                distanceRemain -= currentDistance
            else
                #echo "Marker digambar<br>"
                marker = {}
                marker['lat'] = trip[i + 1]['lat']
                marker['lng'] = trip[i + 1]['lng']
                marker['latdms'] = trip[i + 1]['latdms']
                marker['lngdms'] = trip[i + 1]['lngdms']
                marker['date'] = trip[i + 1]['date']
                marker['time'] = trip[i + 1]['time']
                marker['latlng'] = trip[i + 1]['latlng']
                if(trip[i+1]['additional']!=nil || trip[i+1].has_key?('additional'))
                    marker['additional'] = []
                    #sidestand switch
                    marker['additional'][29] = trip[i+1]['additional'][29]
                    #kill switch
                    marker['additional'][30] = trip[i+1]["additional"][30]
                    #clutch switch
                    marker['additional'][31] = trip[i+1]["additional"][31]
                    #start switch
                    marker['additional'][32] = trip[i+1]["additional"][32]
                    #secondary air valve
                    marker['additional'][20] = trip[i+1]["additional"][20]
                    #actuation of starter relay
                    marker['additional'][21] = trip[i+1]["additional"][21]
                    #lambda sensor heating
                    marker['additional'][22] = trip[i+1]["additional"][22]
                    #electric fuel pump
                    marker['additional'][23] = trip[i+1]["additional"][23]
                    #Electric Fan Pump
                    marker['additional'][24] = trip[i+1]["additional"][24]
                    #Engine Safety Cut Out (of BMSK)
                    marker['additional'][25] = trip[i+1]["additional"][25]
                    #Starter Function (of BMSK)
                    marker['additional'][26] = trip[i+1]["additional"][26]
                    #Starter Safety Cut Out (of BMSK)
                    marker['additional'][27] = trip[i+1]["additional"][27]
                    #Engine Light (MIL)
                    marker['additional'][28] = trip[i+1]["additional"][28]
                    #Injection Time
                    marker['additional'][14] = trip[i+1]["additional"][14]
                    #Lambda Control Factor
                    marker['additional'][15] = trip[i+1]["additional"][15]
                    #Vehicle Speed
                    marker['additional'][1] = trip[i+1]["additional"][1]
                    #Engine RPM
                    marker['additional'][2] = trip[i+1]["additional"][2]
                    #Intake Air Temperature
                    marker['additional'][4] = trip[i+1]["additional"][4]
                    #Engine Temperature
                    marker['additional'][3] = trip[i+1]["additional"][3]
                    #Throttle Position
                    marker['additional'][5] = trip[i+1]["additional"][5]
                    #Engine Load
                    marker['additional'][6] = trip[i+1]["additional"][6]
                    #Battery Voltage
                    marker['additional'][7] = trip[i+1]["additional"][7]
                    #Knock Sensor 1
                    marker['additional'][8] = trip[i+1]["additional"][8]
                    #Knock Sensor 2
                    marker['additional'][9] = trip[i+1]["additional"][9]
                    #Ignition Angle
                    marker['additional'][16] = trip[i+1]["additional"][16]
                    #Ignition Dwell Time
                    marker['additional'][17] = trip[i+1]["additional"][17]
                    #Odometer
                    marker['additional'][10] = trip[i+1]["additional"][10]
                    #Position of Idle Actuator
                    marker['additional'][18] = trip[i+1]["additional"][18]
                    #Position of Idle Actuator at Full Load
                    marker['additional'][19] = trip[i+1]["additional"][19]
                    #Ambient Air Pressure
                    marker['additional'][11] = trip[i+1]["additional"][11]
                    #Lambda Sensor Voltage
                    marker['additional'][12] = trip[i+1]["additional"][12]
                    #Gear
                    marker['additional'][13] = trip[i+1]["additional"][13]
                    marker['additional'][33] = trip[i+1]["additional"][33]
                end
                newTripArray << marker
                distanceRemain = distance
            end
        end

        if(trip.count>1)
            i = trip.count-1
            marker = {}
            marker['lat'] = trip[i]['lat']
            marker['lng'] = trip[i]['lng']
            marker['latdms'] = trip[i]['latdms']
            marker['lngdms'] = trip[i]['lngdms']
            marker['date'] = trip[i]['date']
            marker['time'] = trip[i]['time']
            marker['latlng'] = trip[i]['latlng']
            if(trip[i]['additional']!=nil || trip[i].has_key?('additional'))
                marker['additional'] = []
                #sidestand switch
                marker['additional'][29] = trip[i]['additional'][29]
                #kill switch
                marker['additional'][30] = trip[i]["additional"][30]
                #clutch switch
                marker['additional'][31] = trip[i]["additional"][31]
                #start switch
                marker['additional'][32] = trip[i]["additional"][32]
                #secondary air valve
                marker['additional'][20] = trip[i]["additional"][20]
                #actuation of starter relay
                marker['additional'][21] = trip[i]["additional"][21]
                #lambda sensor heating
                marker['additional'][22] = trip[i]["additional"][22]
                #electric fuel pump
                marker['additional'][23] = trip[i]["additional"][23]
                #Electric Fan Pump
                marker['additional'][24] = trip[i]["additional"][24]
                #Engine Safety Cut Out (of BMSK)
                marker['additional'][25] = trip[i]["additional"][25]
                #Starter Function (of BMSK)
                marker['additional'][26] = trip[i]["additional"][26]
                #Starter Safety Cut Out (of BMSK)
                marker['additional'][27] = trip[i]["additional"][27]
                #Engine Light (MIL)
                marker['additional'][28] = trip[i]["additional"][28]
                #Injection Time
                marker['additional'][14] = trip[i]["additional"][14]
                #Lambda Control Factor
                marker['additional'][15] = trip[i]["additional"][15]
                #Vehicle Speed
                marker['additional'][1] = trip[i]["additional"][1]
                #Engine RPM
                marker['additional'][2] = trip[i]["additional"][2]
                #Intake Air Temperature
                marker['additional'][4] = trip[i]["additional"][4]
                #Engine Temperature
                marker['additional'][3] = trip[i]["additional"][3]
                #Throttle Position
                marker['additional'][5] = trip[i]["additional"][5]
                #Engine Load
                marker['additional'][6] = trip[i]["additional"][6]
                #Battery Voltage
                marker['additional'][7] = trip[i]["additional"][7]
                #Knock Sensor 1
                marker['additional'][8] = trip[i]["additional"][8]
                #Knock Sensor 2
                marker['additional'][9] = trip[i]["additional"][9]
                #Ignition Angle
                marker['additional'][16] = trip[i]["additional"][16]
                #Ignition Dwell Time
                marker['additional'][17] = trip[i]["additional"][17]
                #Odometer
                marker['additional'][10] = trip[i]["additional"][10]
                #Position of Idle Actuator
                marker['additional'][18] = trip[i]["additional"][18]
                #Position of Idle Actuator at Full Load
                marker['additional'][19] = trip[i]["additional"][19]
                #Ambient Air Pressure
                marker['additional'][11] = trip[i]["additional"][11]
                #Lambda Sensor Voltage
                marker['additional'][12] = trip[i]["additional"][12]
                #Gear
                marker['additional'][13] = trip[i]["additional"][13]
                #echo "OBJ33 : ".trip[i]["additional"][33]."<br>"
                marker['additional'][33] = trip[i]["additional"][33]
            end
            newTripArray << marker
            distanceRemain = distance
        end

        newGlobalArray << newTripArray
#    end
    return newGlobalArray
  end


  def get_off_value
      obj = []
      str = "IGNITION OFF"
      # sidestand switch
      obj[29] = str
      # kill switch
      obj[30] = str
      # clutch switch
      obj[31] = str
      # start switch
      obj[32] = str
      # secondary air valve
      obj[20] = str
      # actuation of starter relay
      obj[21] = str
      # lambda sensor heating
      obj[22] = str
      # electric fuel pump
      obj[23] = str
      # Electric Fan Pump
      obj[24] = str
      # Engine Safety Cut Out (of BMSK)
      obj[25] = str
      # Starter Function (of BMSK)
      obj[26] = str
      # Starter Safety Cut Out (of BMSK)
      obj[27] = str
      # Engine Light (MIL)
      obj[28] = str
      # Injection Time
      obj[14] = str
      # Lambda Control Factor
      obj[15] = str
      # Vehicle Speed
      obj[1] = str
      # Engine RPM
      obj[2] = str
      # Intake Air Temperature
      obj[4] = str
      # Engine Temperature
      obj[3] = str
      # Throttle Position
      obj[5] = str
      # Engine Load
      obj[6] = str
      # Battery Voltage
      obj[7] = str
      # Knock Sensor 1
      obj[8] = str
      # Knock Sensor 2
      obj[9] = str
      # Ignition Angle
      obj[16] = str
      # Ignition Dwell Time
      obj[17] = str
      # Odometer
      obj[10] = str
      # Position of Idle Actuator
      obj[18] = str
      # Position of Idle Actuator at Full Load
      obj[19] = str
      # Ambient Air Pressure
      obj[11] = str
      # Lambda Sensor Voltage
      obj[12] = str
      # Gear
      obj[13] = str

      #obj[33] = File_Model::currentName
      return obj
  end

  def read_all_data_without_distance(filepath)
    data_gps = read_all_data(filepath)

    # filtering data
    globalArray = []

    for el in data_gps
        for el2 in el
          if !el2['additional'].nil?
            globalArray << el2
          end
        end
    end
    return globalArray
  end

  def set_selected
    respond_to do |format|
      format.js
    end
  end
  
  def calculateDistance(lat1, long1, lat2, long2)
    r = 6371009
    dLat = toRad(lat2 - lat1)
    dLon = toRad(long2 - long1)

    a = Math::sin(dLat / 2) * Math::sin(dLat / 2) +
            Math::cos(toRad(lat1)) * Math::cos(toRad(lat2)) *
            Math::sin(dLon / 2) * Math::sin(dLon / 2)

    c = 2 * Math::atan2(Math::sqrt(a), Math::sqrt(1 - a))
    
    return (r * c)
  end

  def toRad(val)
    return (val * Math::PI / 180)
  end
  
end

