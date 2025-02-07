#!/usr/bin/fish

# Verify Backend pod
kubectl describe pod todos-backend-pod

# Verify Frontend pod
kubectl describe pod todos-frontend-pod
