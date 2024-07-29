from promptflow.client import PFClient

def main():

    pf = PFClient()
    flow = "./src/chat.prompty"  # path to the prompty file
    data = "./evaluations/test-dataset.jsonl"  # path to the data file

    # base run
    base_run = pf.run(
        flow=flow,
        data=data,
        column_mapping={
            "question": "${data.question}",
            "documents": "${data.documents}"
        },
        stream=True,
    )
    details = pf.get_details(base_run)
    print(details.head(10))


    # Evaluation run
    eval_prompty = "./evaluations/prompty-answer-score-eval.prompty"
    eval_run = pf.run(
        flow=eval_prompty,
        data=data,  
        run=base_run, 
        column_mapping={
            "question": "${data.question}",
            "answer": "${run.outputs.output}",
            "ground_truth": "${data.ground_truth}",
        },
        stream=True,
    )

    details = pf.get_details(eval_run)

    print(details.head(10))

    details = pf.get_details(eval_run)
    details.to_excel("prompty-answer-score-eval.xlsx", index=False)


if __name__ == '__main__':
    import promptflow as pf
    main()