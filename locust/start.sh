#!/bin/bash
locust -f /locust/$LOCUST_FILE --host $TARGET_HOST --$LOCUST_NODE_TYPE $@