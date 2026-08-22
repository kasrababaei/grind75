/*
 Design a time-based key-value data structure that can store multiple values for the same key at
 different time stamps and retrieve the key's value at a certain timestamp.

 Implement the TimeMap class:

 TimeMap() Initializes the object of the data structure.
 void set(String key, String value, int timestamp) Stores the key `key` with the value `value` at
 the given time timestamp.
 
 String get(String key, int timestamp) Returns a value such that set was called previously, with
 timestamp_prev <= timestamp. If there are multiple such values, it returns the value associated
 with the largest timestamp_prev. If there are no values, it returns "".
 
 Example:
 Input ["TimeMap", "set", "get", "get", "set", "get", "get"]
 [[], ["foo", "bar", 1], ["foo", 1], ["foo", 3], ["foo", "bar2", 4], ["foo", 4], ["foo", 5]]
 Output [null, null, "bar", "bar", null, "bar2", "bar2"]

 Explanation
 TimeMap timeMap = new TimeMap();
 timeMap.set("foo", "bar", 1);  // store the key "foo" and value "bar" along with timestamp = 1.
 timeMap.get("foo", 1);         // return "bar"
 timeMap.get("foo", 3);         // return "bar", since there is no value corresponding to foo at
                                // timestamp 3 and timestamp 2, then the only value is at timestamp
                                // 1 is "bar".
 
 timeMap.set("foo", "bar2", 4); // store the key "foo" and value "bar2" along with timestamp = 4.
 timeMap.get("foo", 4);         // return "bar2"
 timeMap.get("foo", 5);         // return "bar2"
 
 1 <= key.length, value.length <= 100
 key and value consist of lowercase English letters and digits.
 1 <= timestamp <= 107
 All the timestamps timestamp of set are strictly increasing.
 At most 2 * 105 calls will be made to set and get.
 */

class TimeMap {
  private var dict: [String: [(value: String, timestamp: Int)]] = [:]
  init() {}
    
  func set(_ key: String, _ value: String, _ timestamp: Int) {
    dict[key, default: []].append((value, timestamp))
  }
    
  func get(_ key: String, _ timestamp: Int) -> String {
    guard let array = dict[key] else { return "" }
        
    var left = 0
    var right = array.count - 1
        
    while left <= right {
      let mid = left + (right - left) / 2
            
      if timestamp == array[mid].timestamp {
        return array[mid].value
      } else if timestamp > array[mid].timestamp {
        left = mid + 1
      } else {
        right = mid - 1
      }
    }
        
    return right >= 0 ? array[right].value : ""
  }
    
  /*
   private var dict: [String: LinkedList] = [:]
     
   func set(_ key: String, _ value: String, _ timestamp: Int) {
       let newHead = LinkedList(nil, value, timestamp)
       if let prevHead = dict[key] {
           newHead.next = prevHead
       }
        
       dict[key] = newHead
   }
    
   func get(_ key: String, _ timestamp: Int) -> String {
       if let list = dict[key] {
           var next: LinkedList? = list
            
           while next != nil {
               if let current = next, timestamp >= current.timestamp {
                   return current.value
               }
                
               next = next?.next
           }
       }
        
       return ""
   }
    */
}

private final class LinkedList {
  var next: LinkedList?
  var value: String = ""
  var timestamp: Int
    
  init(_ next: LinkedList? = nil, _ value: String, _ timestamp: Int) {
    self.next = next
    self.value = value
    self.timestamp = timestamp
  }
}

/**
 * Your TimeMap object will be instantiated and called as such:
 * let obj = TimeMap()
 * obj.set(key, value, timestamp)
 * let ret_2: String = obj.get(key, timestamp)
 */
