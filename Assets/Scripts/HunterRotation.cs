using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class HunterRotation : MonoBehaviour {

    [SerializeField]
    private Transform player;

    private SpriteRenderer spriteRenderer;

    private void Awake()
    {
        spriteRenderer = GetComponent<SpriteRenderer>();
    }

    // Update is called once per frame
    void Update () {
        Vector3 moveDirection = gameObject.transform.position - player.position;
        if (moveDirection.x < 0)
        {
            spriteRenderer.flipX=false;

        }
        else
        {
            spriteRenderer.flipX = true;
        }
    }
}
