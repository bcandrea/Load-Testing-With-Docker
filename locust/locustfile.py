from locust import HttpLocust, TaskSet, task

class WebsiteTasks(TaskSet):
   @task(2)
   def getStatusForLondon(self):
       self.client.get("/api/weatherstatusforeurope/london")

   @task(4)
   def getStatusForParis(self):
       self.client.get("/api/weatherstatusforeurope/paris")

   @task(6)
   def getStatusForRome(self):
       self.client.get("/api/weatherstatusforeurope/rome")

   @task(8)
   def getStatusForTokyo(self):
       self.client.get("/api/weatherstatusforasia/tokyo")

class WebsiteUser(HttpLocust):
   task_set = WebsiteTasks
   min_wait = 50
   max_wait = 150
