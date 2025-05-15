
clean-iac:
	rm -f iac/views/build/*.yaml; \
	rm -f iac/procedures/build/*.yaml; \
	rm -f iac/tables/build/*.json; \
	rm -f iac/schedueled_queries/build/*.yaml; \
	rm -frd iac/functions/make_predictions/__pycache__; \
	rm -frd iac/functions/make_predictions/htmlcov
	rm -f iac/functions/make_predictions/.coverage

prepare-iac:
	@if [ -z "$$TF_VAR_project" ]; then \
		echo "Error: TF_VAR_project environment variable is not set"; \
		echo "Please set it with: export TF_VAR_project=PROJECT_ID"; \
		echo "See README.md for more information"; \
		exit 1; \
	fi
	cd tools; \
	TF_VAR_project="$$TF_VAR_project" sh generate_iac.sh;

plan : clean-iac prepare-iac
	cd iac; \
	tfsec; \
	terraform plan;

deploy : plan
	cd iac && terraform apply -auto-approve

run-tests:
	cd iac/functions/make_predictions; \
	coverage run --source=. binancebot_test.py ; \
	coverage report; \
	coverage html;

init:
	cd iac; \
	terraform init;
