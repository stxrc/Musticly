using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class ProgressiveText : MonoBehaviour {


    public bool progressive;

    private Text description;

    void Awake()
    {
        description = GetComponent<Text>();
 
    }

    void OnEnable()
    {
       TypeText();
    }


    public void TypeText()
    {

        string temp = description.text;

        description.text = "";
        StartCoroutine(TypeSentence(temp));
    }

    IEnumerator TypeSentence(string temp)
    {
        for (int i = 0; i <= temp.Length; i++)
        {
            description.text = temp.Substring(0, i);
            yield return new WaitForSeconds(0.01f);
        }
    }
}
