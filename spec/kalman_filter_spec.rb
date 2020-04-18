require 'kalman_filter'

RSpec.describe KalmanFilter, "#value" do

  context "with a default filter" do
    kf = KalmanFilter.new

    it "#measurement = 65" do
      kf.measurement = 65
      expect(kf.measurement).to eq 65
    end

    it "checking #value is equal to #measurement" do
      expect(kf.value).to eq kf.measurement
    end

    it "#measurement = 72" do
      kf.measurement = 72
      expect(kf.measurement).to eq 72
    end

    it "checking #value for second #measurement" do
      expect(kf.value).to eq 69.66666666666667
    end

    it "checking for decreasing #kalman_gain" do
      expect(kf.kalman_gain).to eq 0.6666666666666666
      kf.measurement = 80
      expect(kf.value).to eq 76.125
      expect(kf.kalman_gain).to eq 0.6249999999999999
      kf.measurement = 100
      expect(kf.value).to eq 90.9047619047619
      expect(kf.kalman_gain).to eq 0.6190476190476191
    end
  end

  context "simulation" do
    kf = KalmanFilter.new process_noise: 0.1, measurement_noise: 1.5

    it "works" do
      expect(kf.value).to be nil

      puts "Simulating..."
      puts "Measurement\tTrue Value\tKalman Gain\tCovariance"
      1..100.times do
        rand = rand(100)
        kf.measurement = rand
        puts "#{ rand }\t#{ kf.value }\t#{ kf.kalman_gain }\t#{ kf.covariance }"
      end

      expect(kf.value > 0)
      expect(kf.kalman_gain < 1.0)
    end
  end
end
