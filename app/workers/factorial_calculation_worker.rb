class FactorialCalculationWorker
    include Sneakers::Worker
    # This worker will connect to "factorial.calculations" queue
    # env is set to nil since by default the actuall queue name would be
    # "factorial.calculations_development"
    from_queue "factorial.calculations", env: nil
  
    # work method receives message payload in raw format
    # in our case it is JSON encoded string
  
    def work(raw_number)
      num_to_hash = JSON.parse raw_number
      number = num_to_hash["number"]
      puts "Received number: #{number}"
      ack! # we need to let queue know that message was received
      calculate_factorial(number)
    end

    def calculate_factorial(number)
      result = `python factorial.py #{number}`
      puts "Result: #{result}"
      Publisher.publish("send_result", {result: result})
    end
  end