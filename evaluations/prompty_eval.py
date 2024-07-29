from promptflow.client import PFClient

def main():

    pf = PFClient()
    flow = "./src"  # path to the prompty file
    data = "./evaluations/test-dataset.jsonl"  # path to the data file

    # base run
    base_run = pf.run(
        flow=flow,
        data=data,
        column_mapping={
            "question": "${data.question}",
            "chat_history": []
        },
        stream=True,
    )

    details = pf.get_details(base_run)
    print(details.head(10))


    # Evaluation run
    eval_prompty = "./evaluations/flow-groundedness-eval.prompty"
    eval_run = pf.run(
        flow=eval_prompty,
        data=data, 
        run=base_run, 
        column_mapping={
            "answer": "${run.outputs.answer}", 
            "context": "${run.outputs.context}",
        },
        stream=True,
    )

    details = pf.get_details(eval_run)
    print(details.head(10))

    details = pf.get_details(eval_run)
    details.to_excel("flow-groundedness-eval.xlsx", index=False)


if __name__ == '__main__':
    import promptflow as pf
    main()