.PHONY: run go-mod

openapi:
	operator-sdk generate k8s
	operator-sdk generate crds
	operator-sdk build fishpro3/imoocpod-operator
	sed -i "" 's|REPLACE_IMAGE|fishpro3/imoocpod-operator|g' deploy/operator.yaml

apply:
	kubectl apply -f deploy/service_account.yaml -n operator --kubeconfig /tmp/kubeconfig
	kubectl apply -f deploy/role.yaml -n operator --kubeconfig /tmp/kubeconfig
	kubectl apply -f deploy/role_binding.yaml -n operator --kubeconfig /tmp/kubeconfig
	kubectl apply -f deploy/crds/k8s.imooc.com_imoocpods_crd.yaml -n operator --kubeconfig /tmp/kubeconfig
	kubectl apply -f deploy/operator.yaml -n operator --kubeconfig /tmp/kubeconfig
	kubectl apply -f deploy/crds/k8s.imooc.com_v1alpha1_imoocpod_cr.yaml -n operator --kubeconfig /tmp/kubeconfig

delete:
	kubectl delete -f deploy/service_account.yaml -n operator --kubeconfig /tmp/kubeconfig
	kubectl delete -f deploy/role.yaml -n operator --kubeconfig /tmp/kubeconfig
	kubectl delete -f deploy/role_binding.yaml -n operator --kubeconfig /tmp/kubeconfig
	kubectl delete -f deploy/crds/k8s.imooc.com_imoocpods_crd.yaml -n operator --kubeconfig /tmp/kubeconfig
	kubectl delete -f deploy/operator.yaml -n operator --kubeconfig /tmp/kubeconfig
	kubectl delete -f deploy/crds/k8s.imooc.com_v1alpha1_imoocpod_cr.yaml -n operator --kubeconfig /tmp/kubeconfig

go-mod:
	go mod tidy && go mod vendor
