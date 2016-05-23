import requests

class SputnikAPI:
  # Example: server.set_password('abc')
  def set_password(self, password):
    self.password = password
  
  # Example: server.set_host('sputnik-bsu.herokuapp.com')
  def set_host(self, url):
    self.url = 'http://'+url+'/api/v1/sensors'

  # Example: server.push('payloads', 'humidity', 21, 10)
  def push(self, category, sensor, value, time):
    data = {'password': self.password, 'category_name': category, 'sensor_name': sensor, 'value': value, 'time': time}
    r = requests.post(self.url, data=data)
    print r.content



server = SputnikAPI()
server.set_password('abc')
server.set_host('localhost:3000')
server.push('payloads', 'humidity', 21, 10)
