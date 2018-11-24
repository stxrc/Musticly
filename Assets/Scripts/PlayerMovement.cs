using System.Collections;
using System.Collections.Generic;
using UnityEngine;


public class PlayerMovement : MonoBehaviour {

    public float speed = 0.2f;
    private Rigidbody2D rigid;
    private bool isGrounded = true;
    private SpriteRenderer spriteRenderer;

    private Animator anim;

    private void Start()
    {
        rigid = GetComponent<Rigidbody2D>();
        spriteRenderer = GetComponent<SpriteRenderer>();
        anim = GetComponent<Animator>();
    }

    // Update is called once per frame
    void Update () {

        float moveHorizontal = Input.GetAxis("Horizontal");
        Vector3 movement = new Vector3(moveHorizontal, 0.0f, 0);
        if (moveHorizontal != 0)
        {
            anim.SetBool("isWalking", true);
        }
        else
        {
            anim.SetBool("isWalking", false);
        }
        if (movement.x !=0 )
        {
            spriteRenderer.flipX = (movement.x < 0) ? true : false;
        }

        gameObject.transform.position += movement * speed;

        if (Input.GetKeyDown(KeyCode.Space) && isGrounded)
        {
            rigid.AddForce(new Vector2(0, 13), ForceMode2D.Impulse);
            isGrounded = false;
            anim.SetBool("isJumping", true);
        }

    }
    private void OnCollisionEnter2D(Collision2D collision)
    {
    
        if (collision.gameObject.layer == LayerMask.NameToLayer("Ground")) // ground on layer 8
        {
            isGrounded = true;
            anim.SetBool("isJumping", false);
        }
    }
}
