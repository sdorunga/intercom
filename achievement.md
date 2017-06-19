# What's your proudest achievement?

In one of the projects I was working on, I was tasked with tracking user events
and posting them to an external service for analysis. After I implemented the
 feature and people started tracking more and more as well as the company gaining
customers it started to put pressure on our background processing queue so I started
 working on a ticket to improve it. The issue was caused by high latency on 
processing the events on the external service's side. I was told by our architect 
and my tech lead to implement some batching and threading of the events to reduce 
the load, which I did, but didn't see enough increase in performance.

This was impacting both developer productivity (our queues were always backed
up and was causing a lot of issues that the developers had to firefight) and had
significant customer impact since important backround taks (like emails and billing
reconciliation) were being significantly delayed together with their related 
analytics data, often to the tune of 24h. I wanted to do more but was told by the 
architect that that was the most we could do and it wasn't worth it to spend 
extra time on it.

It seemed important enough to me to follow up on it when I had spare time. I had 
a hunch that the backround processor we were using was the bottleneck so I made 
a proof of concept microservice that would receive domain events and broadcast 
them to external services that we wanted to receive them. We couldn't migrate 
from the old processor as it was part of a creaky old monolith that would have 
made it difficult to shift. The new service was about 100x more performant on 
this specific use case and after I presented it to the my tech lead and product 
owner I was given the time to build a proper production version that resulting 
in removing most of the load from the monolith's processor. This helped reduce 
pressure on our infrastracture and allowed for both our customers to receive 
updates faster. This had the aded benefit of helping our analytics team as they 
were relying on the event data to make decisions and the delays meant they weren't 
able to check on A/B tests quickly enough.

